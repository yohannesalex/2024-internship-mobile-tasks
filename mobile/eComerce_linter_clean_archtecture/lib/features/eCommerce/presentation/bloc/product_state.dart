part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class InitialState extends ProductState {}

class LoadingState extends ProductState {}

class LoadedAllProductState extends ProductState {
  final ProductEntity product;

  const LoadedAllProductState({required this.product});
}

class LoadedSingleProductState extends ProductState {
  final ProductEntity product;

  const LoadedSingleProductState({required this.product});
}

class ErrorState extends ProductState {
  final String message;

  const ErrorState({required this.message});
}
