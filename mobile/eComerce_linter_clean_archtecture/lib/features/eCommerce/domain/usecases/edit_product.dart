import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class EditProductUsecase {
  final ProductRepository productRepository;
  EditProductUsecase(this.productRepository);

  Future<Either<Failure, void>> call(ProductEntity product) {
    return productRepository.editProduct(product);
  }
}
