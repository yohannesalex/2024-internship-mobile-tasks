import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase {
  final ProductRepository productRepository;
  AddProductUsecase(this.productRepository);

  Future<Either<Failure, void>> execute(ProductEntity product) {
    return productRepository.addProduct(product);
  }
}
