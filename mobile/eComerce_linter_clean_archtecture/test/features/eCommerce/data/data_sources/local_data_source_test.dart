import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/error/exeptions.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/local_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/models/product_model.dart';

import '../../helpers/read_json.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
  group('getAllProducts', () {
    final jsonList = json.decode(
        readJson('features/eCommerce/helpers/dummy_data/product_cached.json'));
    final testProductModelList = ProductModel.fromJsonList(jsonList);
    const CACHED_PRODUCTS = 'CACHED_PRODUCTS';
    test(
        'should return cached products from shared reference when there is one in the cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(json.encode(jsonList));

      //act
      final result = await dataSource.getAllProducts();

      //assert
      verify(mockSharedPreferences.getString(CACHED_PRODUCTS));
      expect(result, equals(testProductModelList));
    });
    test('should throw cache exception when there is not a cached value',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      //act
      final call = dataSource.getAllProducts;

      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('cacheAllProducts', () {
    const CACHED_PRODUCTS = 'CACHED_PRODUCTS';
    const testProductModelList = [
      ProductModel(
          id: '1',
          name: 'Test shoes',
          description: 'A brand nike for the summer',
          imageUrl: 'nike.jpg',
          price: 15.33)
    ];

    test('should call SharedPreference to cache the data', () {
      //arrange
      final expectedJson =
          json.encode(ProductModel.toJsonList(testProductModelList));
      when(mockSharedPreferences.setString(any, expectedJson))
          .thenAnswer((_) async => true);

      //act
      dataSource.cacheAllProducts(testProductModelList);

      //assert

      verify(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJson));
    });
  });
}
