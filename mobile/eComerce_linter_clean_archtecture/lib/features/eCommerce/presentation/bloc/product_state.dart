part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class InitialState extends ProductState {}

class LoadingState extends ProductState {}

class SuccessState extends ProductState {}

class LoadedAllProductState extends ProductState {
  final List<ProductEntity> productList;

  const LoadedAllProductState({required this.productList});
}

class LoadedSingleProductState extends ProductState {
  final ProductEntity product;

  const LoadedSingleProductState({required this.product});
}

class ErrorState extends ProductState {
  final String message;

  const ErrorState({required this.message});
}
