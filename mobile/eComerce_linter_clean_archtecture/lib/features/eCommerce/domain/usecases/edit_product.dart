import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class EditProductUsecase implements UseCase<void, EditParams> {
  final ProductRepository productRepository;
  EditProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, void>> call(EditParams editparams) async {
    return await productRepository.editProduct(editparams.product);
  }
}

class EditParams extends Equatable {
  final ProductEntity product;

  const EditParams({required this.product});
  @override
  List<Object?> get props => [product];
}
