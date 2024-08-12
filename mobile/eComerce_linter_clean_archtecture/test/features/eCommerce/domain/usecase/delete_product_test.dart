import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:my_project_name/features/eCommerce/domain/usecases/delete_product.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteProductUsecase deleteProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUsecase = DeleteProductUsecase(mockProductRepository);
  });

  const testProductId = '1';
  test('should delete the product from the repository', () async {
    //arrange

    when(mockProductRepository.deleteProduct(any))
        .thenAnswer((_) async => const Right(null));
    //act
    final result = await deleteProductUsecase(testProductId);
    //assert
    expect(result, const Right(null));
    verify(mockProductRepository.deleteProduct(testProductId));
  });
}
