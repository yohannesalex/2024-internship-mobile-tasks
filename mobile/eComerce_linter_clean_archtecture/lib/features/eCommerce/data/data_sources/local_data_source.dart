import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel> getAllProducts(String productId);

  Future<void> cacheAllProducta(List<ProductModel> producToCache);
}
