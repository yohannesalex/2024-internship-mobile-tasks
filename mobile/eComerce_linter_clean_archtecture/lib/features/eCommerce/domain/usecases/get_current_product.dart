import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetCurrentProductUsecase {
  final ProductRepository productRepository;
  GetCurrentProductUsecase(this.productRepository);
  Future<Either<Failure, ProductEntity>> call(Params params) {
    return productRepository.getCurrentProduct(params.productId);
  }
}

class Params extends Equatable {
  final String productId;

  const Params({required this.productId});
  @override
  List<Object?> get props => [productId];
}
