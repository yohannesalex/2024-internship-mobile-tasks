import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.category,
      required super.description,
      required super.price,
      required super.imageUrl});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  ProductEntity toEntity() => ProductEntity(
      id: id,
      category: category,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl);

  static List<ProductEntity> toEntityList(List<ProductModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  static ProductModel toModel(ProductEntity product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      category: product.category,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
  }

  static List<Map<String, dynamic>> toJsonList(List<ProductModel> products) {
    return products.map((product) => product.toJson()).toList();
  }
}
