import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository productRepository;
  DeleteProductUsecase(this.productRepository);

  Future<Either<Failure, void>> call(Params params) {
    return productRepository.deleteProduct(params.productId);
  }
}

class Params extends Equatable {
  final String productId;

  const Params({required this.productId});

  @override
  List<Object?> get props => [id];
}
