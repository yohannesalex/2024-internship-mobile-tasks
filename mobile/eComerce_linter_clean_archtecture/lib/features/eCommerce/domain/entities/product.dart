import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String imageUrl;

  const ProductEntity(
      {required this.id,
      required this.name,
      required this.category,
      required this.description,
      required this.price,
      required this.imageUrl});
  @override
  List<Object?> get props => [id, category, name, description, price, imageUrl];
}
