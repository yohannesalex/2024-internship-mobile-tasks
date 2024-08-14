import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/add_product.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late AddProductUsecase addProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    addProductUsecase = AddProductUsecase(mockProductRepository);
  });
  const testProductdetail = ProductEntity(
      id: '1',
      name: 'Nike',
      description: 'brand new nike aiforce',
      price: 23.4,
      imageUrl: 'imageUrl');

  test('should all the product to the repository', () async {
    //arrange

    when(mockProductRepository.addProduct(any))
        .thenAnswer((_) async => const Right(null));
    //act
    final result = await addProductUsecase(testProductdetail);
    //assert
    expect(result, const Right(null));
    verify(mockProductRepository.addProduct(testProductdetail));
  });
}
