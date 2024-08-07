import 'package:flutter/material.dart';
class Product{
  String name;
  String category;
  String description;
  double price;
  AssetImage image;
  Product(this.name , this.category, this.description, this.price, this.image);
  @override
  String toString() => "name $name";
}