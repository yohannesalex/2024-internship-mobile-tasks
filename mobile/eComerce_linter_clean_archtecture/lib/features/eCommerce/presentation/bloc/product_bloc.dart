import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/edit_product.dart';
import '../../domain/usecases/get_all_product.dart';
import '../../domain/usecases/get_current_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetCurrentProductUsecase getCurrentProductUsecase;
  final GetAllProductUsecase getAllProductUsecase;
  final InputConverter inputConverter;
  final DeleteProductUsecase deleteProductUsecase;
  final AddProductUsecase addProductUsecase;
  final EditProductUsecase editProductUsecase;

  ProductBloc(
    super.initialState, {
    required GetCurrentProductUsecase current,
    required GetAllProductUsecase all,
    required EditProductUsecase edit,
    required DeleteProductUsecase delete,
    required AddProductUsecase add,
    required this.inputConverter,
  })  : getCurrentProductUsecase = current,
        getAllProductUsecase = all,
        editProductUsecase = edit,
        deleteProductUsecase = delete,
        addProductUsecase = add;

  @override
  ProductState get initialState => InitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    // TODO: Add Logic
  }
}
