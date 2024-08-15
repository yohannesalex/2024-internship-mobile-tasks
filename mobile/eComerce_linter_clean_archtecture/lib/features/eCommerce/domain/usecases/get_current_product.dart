import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetCurrentProductUsecase
    implements UseCase<ProductEntity, CurrentParams> {
  final ProductRepository productRepository;
  GetCurrentProductUsecase(this.productRepository);
  @override
  Future<Either<Failure, ProductEntity>> call(
      CurrentParams currentParams) async {
    return await productRepository.getCurrentProduct(currentParams.productId);
  }
}

class CurrentParams extends Equatable {
  final String productId;

  const CurrentParams({required this.productId});
  @override
  List<Object?> get props => [productId];
}
