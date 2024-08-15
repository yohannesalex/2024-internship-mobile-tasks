import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/error/exeptions.dart';
import 'package:my_project_name/core/error/failure.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/add_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/delete_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/edit_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/get_all_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/get_current_product.dart';
import 'package:my_project_name/features/eCommerce/presentation/bloc/product_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductBloc productBloc;
  late MockGetAllProductUsecase mockGetAllProductUsecase;
  late MockGetCurrentProductUsecase mockGetCurrentProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockEditProductUsecase mockEditProductUsecase;
  late MockAddProductUsecase mockAddProductUsecase;
  setUp(() {
    mockGetCurrentProductUsecase = MockGetCurrentProductUsecase();
    mockAddProductUsecase = MockAddProductUsecase();
    mockEditProductUsecase = MockEditProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    mockGetAllProductUsecase = MockGetAllProductUsecase();
    productBloc = ProductBloc(
        mockAddProductUsecase,
        mockGetCurrentProductUsecase,
        mockEditProductUsecase,
        mockDeleteProductUsecase,
        mockGetAllProductUsecase);
  });
  const testProductdetail = ProductEntity(
      id: '1',
      name: 'Nike',
      description: 'brand new nike aiforce',
      price: 23.4,
      imageUrl: 'imageUrl');
  const testProductId = '1';
  const testListProductdetail = [
    ProductEntity(
        id: '1',
        name: 'Nike',
        description: 'brand new nike aiforce',
        price: 23.4,
        imageUrl: 'imageUrl'),
    ProductEntity(
        id: '1',
        name: 'Nike',
        description: 'brand new nike aiforce',
        price: 23.4,
        imageUrl: 'imageUrl')
  ];

  test('initial state should be empty', () {
    expect(productBloc.state, InitialState());
  });
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, LoadedSingleProduct] on get single event',
      build: () {
        when(mockGetCurrentProductUsecase(
                const CurrentParams(productId: testProductId)))
            .thenAnswer((_) async => const Right(testProductdetail));
        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(testProductId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            LoadingState(),
            const LoadedSingleProductState(product: testProductdetail)
          ]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, ErrorState] on get single event',
      build: () {
        when(mockGetCurrentProductUsecase(
                const CurrentParams(productId: testProductId)))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(testProductId)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Server Failure')]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, LoadedAllProduct] on get all event',
      build: () {
        when(mockGetAllProductUsecase())
            .thenAnswer((_) async => const Right(testListProductdetail));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            LoadingState(),
            const LoadedAllProductState(productList: testListProductdetail)
          ]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, ErrorState] on get all event',
      build: () {
        when(mockGetAllProductUsecase())
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Server Failure')]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, SuccessState] oni edit event',
      build: () {
        when(mockEditProductUsecase(
                const EditParams(product: testProductdetail)))
            .thenAnswer((_) async => const Right(null));
        return productBloc;
      },
      act: (bloc) => bloc.add(const UpdateProductEvent(testProductdetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [LoadingState(), SuccessState()]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, ErrorState] on edit event',
      build: () {
        when(mockEditProductUsecase(
                const EditParams(product: testProductdetail)))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(const UpdateProductEvent(testProductdetail)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Server Failure')]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, SuccessState] on create event',
      build: () {
        when(mockAddProductUsecase(const AddParams(product: testProductdetail)))
            .thenAnswer((_) async => const Right(null));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(testProductdetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [LoadingState(), SuccessState()]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, ErrorState] on create event',
      build: () {
        when(mockAddProductUsecase(const AddParams(product: testProductdetail)))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(testProductdetail)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Server Failure')]);

  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, SuccessState] on delete event',
      build: () {
        when(mockDeleteProductUsecase(
                const DeleteParams(productId: testProductId)))
            .thenAnswer((_) async => const Right(null));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(testProductId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [LoadingState(), SuccessState()]);
  blocTest<ProductBloc, ProductState>(
      'should emit [Loading, ErrorState] on delete event',
      build: () {
        when(mockDeleteProductUsecase(
                const DeleteParams(productId: testProductId)))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(testProductId)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Server Failure')]);
}
