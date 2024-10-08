import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/error/exeptions.dart';
import '../../../authentication/data/resource/auth_local_data_source.dart';
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
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri = Uri.parse('${Uris.baseUrl}/products');
    final request = http.MultipartRequest(
      'POST',
      uri,
    );
    request.fields.addAll({
      'name': product.name,
      'description': product.description,
      'price': product.price.toString(),
    });
    request.files.add(await http.MultipartFile.fromPath(
        'image', product.imageUrl,
        contentType: MediaType('image', 'jpg')));
    request.headers['Authorization'] = 'Bearer $token';
    final response = await request.send();

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final response = await client.delete(
      Uri.parse('${Uris.baseUrl}/products/$productId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> editProduct(ProductModel product) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final productId = product.id;
    final jsonBody = {
      'name': product.name,
      'description': product.description,
      'price': product.price,
    };

    final response = await client.put(
      Uri.parse('${Uris.baseUrl}/products/$productId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(jsonBody),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri = Uri.parse('${Uris.baseUrl}/products');
    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJsonList(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getCurrentProduct(String productId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri = Uri.parse('${Uris.baseUrl}/products/$productId');
    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }
}
