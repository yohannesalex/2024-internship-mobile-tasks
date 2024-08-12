import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/edit_product.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late EditProductUsecase editProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    editProductUsecase = EditProductUsecase(mockProductRepository);
  });
  const testProductdetail = ProductEntity(
      id: '1',
      name: 'Nike',
      category: 'Shoes',
      description: 'brand new nike aiforce',
      price: 23.4,
      imageUrl: 'imageUrl');
  const updatedTestProductDetail = ProductEntity(
      id: '1',
      name: 'puma',
      category: 'Shoes',
      description: 'brand new nike aiforce',
      price: 30.8,
      imageUrl: 'imageUrl');

  test('should edit the product from the repository', () async {
    //arrange

    when(mockProductRepository.editProduct(any))
        .thenAnswer((_) async => const Right(updatedTestProductDetail));
    //act
    final result = await editProductUsecase(testProductdetail);
    //assert
    expect(result, const Right(updatedTestProductDetail));
    verify(mockProductRepository.editProduct(testProductdetail));
  });
}
