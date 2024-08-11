import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetCurrentProductUsecase {
  final ProductRepository productRepository;
  GetCurrentProductUsecase(this.productRepository);
  Future<Either<Failure, ProductEntity>> execute(String productId) {
    return productRepository.getCurrentProduct(productId);
  }
}
