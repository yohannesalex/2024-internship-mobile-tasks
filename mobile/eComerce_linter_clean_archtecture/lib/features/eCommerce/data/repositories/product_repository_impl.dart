import '../../../../core/error/exeptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import '../models/product_model.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.productRemoteDataSource,
      required this.productLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.addProduct(ProductModel.toModel(product));
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.deleteProduct(productId);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource
            .editProduct(ProductModel.toModel(product));
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productRemoteDataSource.getAllProducts();
        await productLocalDataSource.cacheAllProducts(result);

        return Right(ProductModel.toEntityList(result));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await productLocalDataSource.getAllProducts();
        return Right(ProductModel.toEntityList(result));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getCurrentProduct(
      String productId) async {
    if (await networkInfo.isConnected) {
      networkInfo.isConnected;
      try {
        return (Right(
            await productRemoteDataSource.getCurrentProduct(productId)));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
