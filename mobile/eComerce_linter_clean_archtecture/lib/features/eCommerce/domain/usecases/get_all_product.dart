import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProductUsecase {
  final ProductRepository productRepository;
  GetAllProductUsecase(this.productRepository);
  Future<Either<Failure, List<ProductEntity>>> call() {
    return productRepository.getAllProducts();
  }
}
