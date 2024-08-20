import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/get_current_product.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentProductUsecase getCurrentProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    getCurrentProductUsecase = GetCurrentProductUsecase(mockProductRepository);
  });
  const testProductdetail = ProductEntity(
      id: '1',
      name: 'Nike',
      description: 'brand new nike aiforce',
      price: 23.4,
      imageUrl: 'imageUrl');
  const testProductId = '1';
  test('should get the product from the repository', () async {
    //arrange

    when(mockProductRepository.getCurrentProduct(any))
        .thenAnswer((_) async => const Right(testProductdetail));
    //act
    final result = await getCurrentProductUsecase(
        const CurrentParams(productId: testProductId));
    //assert
    expect(result, const Right(testProductdetail));
    verify(mockProductRepository.getCurrentProduct(testProductId));
  });
}
