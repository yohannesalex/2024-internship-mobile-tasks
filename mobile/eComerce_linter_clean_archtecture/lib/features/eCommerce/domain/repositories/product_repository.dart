import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getCurrentProduct(String productId);
  Future<Either<Failure, void>> addProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(String productId);
  Future<Either<Failure, void>> editProduct(ProductEntity product);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}
