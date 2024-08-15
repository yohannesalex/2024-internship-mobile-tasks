import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase implements UseCase<void, AddParams> {
  final ProductRepository productRepository;
  AddProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, void>> call(AddParams addparams) async {
    return await productRepository.addProduct(addparams.product);
  }
}

class AddParams extends Equatable {
  final ProductEntity product;

  const AddParams({required this.product});
  @override
  List<Object?> get props => [product];
}
