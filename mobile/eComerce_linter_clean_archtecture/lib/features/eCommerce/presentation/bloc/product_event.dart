part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ProductEvent {}

class GetSingleProductEvent extends ProductEvent {
  final String prodcutId;

  const GetSingleProductEvent(this.prodcutId);
  @override
  List<Object> get props => [prodcutId];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;

  const UpdateProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class CreateProductEvent extends ProductEvent {
  final ProductEntity product;

  const CreateProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String prodcutId;

  const DeleteProductEvent(this.prodcutId);
  @override
  List<Object> get props => [prodcutId];
}
