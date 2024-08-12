import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getCurrentProduct(String productId);
  Future<void> addProduct(ProductEntity product);
  Future<void> deleteProduct(String productId);
  Future<void> editProduct(ProductEntity product);
  Future<List<ProductModel>> getAllProduct();
}
