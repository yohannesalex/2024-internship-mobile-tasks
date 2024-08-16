import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';

import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/edit_product.dart';
import '../../domain/usecases/get_all_product.dart';
import '../../domain/usecases/get_current_product.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetCurrentProductUsecase _getCurrentProductUsecase;
  final GetAllProductUsecase _getAllProductUsecase;
  final DeleteProductUsecase _deleteProductUsecase;
  final AddProductUsecase _addProductUsecase;
  final EditProductUsecase _editProductUsecase;

  ProductBloc(
    this._addProductUsecase,
    this._getCurrentProductUsecase,
    this._editProductUsecase,
    this._deleteProductUsecase,
    this._getAllProductUsecase,
  ) : super(InitialState()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _getCurrentProductUsecase(
          CurrentParams(productId: event.prodcutId));
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LoadedSingleProductState(product: data));
      });
    }, transformer: debounce(const Duration(milliseconds: 300)));
    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _getAllProductUsecase();

      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LoadedAllProductState(productList: data));
      });
    });
    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result =
          await _editProductUsecase(EditParams(product: event.product));
      print('i am here');
      print(result);
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(SuccessState());
      });
    });
    on<CreateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result =
          await _addProductUsecase(AddParams(product: event.product));
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(SuccessState());
      });
    });
    on<DeleteProductEvent>((event, emit) async {
      emit(LoadingState());
      final result =
          await _deleteProductUsecase(DeleteParams(productId: event.prodcutId));
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(SuccessState());
      });
    });
  }
}

EventTransformer<GetSingleProductEvent> debounce<T>(Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}
