import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constant.dart';
import '../../../../core/error/exeptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getCurrentProduct(String productId);
  Future<void> addProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
  Future<void> editProduct(ProductModel product);
  Future<List<ProductModel>> getAllProducts();
}

class ProdcutRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProdcutRemoteDataSourceImpl({required this.client});
  @override
  Future<void> addProduct(ProductModel product) async {
    final uri = Uri.parse(Uris.baseUrl);
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'name': product.name,
      'description': product.description,
      'price': product.price.toString(),
      'imageUrl': product.imageUrl
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', product.imageUrl));

    final response = await request.send();

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final response = await client.delete(
      Uri.parse('${Uris.baseUrl}/$productId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> editProduct(ProductModel product) async {
    final productId = product.id;
    final jsonBody = {
      'name': product.name,
      'description': product.description,
      'price': product.price,
    };

    final response = await client.put(
      Uri.parse('${Uris.baseUrl}/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final uri = Uri.parse(Uris.baseUrl);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return ProductModel.fromJsonList(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getCurrentProduct(String productId) async {
    final uri = Uri.parse('${Uris.baseUrl}$productId');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }
}
