import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exeptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<void> cacheAllProducts(List<ProductModel> producToCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  final CACHED_PRODUCTS = 'CACHED_PRODUCTS';
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAllProducts(List<ProductModel> producToCache) {
    try {
      final jsonProduct = json.encode(ProductModel.toJsonList(producToCache));

      return sharedPreferences.setString(CACHED_PRODUCTS, jsonProduct);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() {
    try {
      final productsString = sharedPreferences.getString(CACHED_PRODUCTS);
      if (productsString != null) {
        final decodedJson = json.decode(productsString);

        return Future.value(ProductModel.fromJsonList(decodedJson));
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
