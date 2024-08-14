import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/features/eCommerce/data/models/product_model.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';

import '../../helpers/read_json.dart';

void main() {
  const testProductModel = ProductModel(
      id: '1',
      name: 'item 1',
      description: 'item 2 description',
      price: 19.0,
      imageUrl: 'item 1.jpg');
  final expectedJson = {
    'id': '1',
    'name': 'item 1',
    'price': 19.0,
    'description': 'item 2 description',
    'imageUrl': 'item 1.jpg'
  };

  test('should be the subclass of product entity', () async {
    expect(testProductModel, isA<ProductEntity>());
  });

  test('should return the valid model from the json', () async {
    final Map<String, dynamic> jsonMap = json.decode(readJson(
        'features/eCommerce/helpers/dummy_data/dummy_product_entity_response.json'));
    final result = ProductModel.fromJson(jsonMap);
    expect(testProductModel, result);
  });

  test('should return a json map containning proper data', () async {
    final result = testProductModel.toJson();
    expect(result, expectedJson);
  });
}
