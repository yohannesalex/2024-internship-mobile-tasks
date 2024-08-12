import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/get_all_product.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllProductUsecase getAllProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProductUsecase = GetAllProductUsecase(mockProductRepository);
  });
  const testProductdetail = [
    ProductEntity(
        id: '1',
        name: 'Nike',
        category: 'Shoes',
        description: 'brand new nike airforce',
        price: 23.4,
        imageUrl: 'imageUrl'),
    ProductEntity(
        id: '2',
        name: 'Adidas',
        category: 'Shoes',
        description: 'brand new adidas easy',
        price: 23.4,
        imageUrl: 'imageUrl')
  ];

  test('should get all products from the repository', () async {
    //arrange
    when(mockProductRepository.getAllProduct())
        .thenAnswer((_) async => const Right(testProductdetail));
    //act
    final result = await getAllProductUsecase();
    //assert
    expect(result, const Right(testProductdetail));
    verify(mockProductRepository.getAllProduct());
  });
}
