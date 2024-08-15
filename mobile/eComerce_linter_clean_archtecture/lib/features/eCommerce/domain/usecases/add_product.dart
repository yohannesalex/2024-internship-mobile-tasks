import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase {
  final ProductRepository productRepository;
  AddProductUsecase(this.productRepository);

  Future<Either<Failure, void>> call(Params params) {
    return productRepository.addProduct(params.product);
  }
}

class Params extends Equatable {
  final ProductEntity product;

  const Params({required this.product});
  @override
  List<Object?> get props => [product];
}
