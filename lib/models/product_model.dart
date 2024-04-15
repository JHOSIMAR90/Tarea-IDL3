import 'package:get/get.dart';

class ProductModel {
  final String id;
  final String slug;
  final String name;
  final String description;
  final double price;
  final int stock;
  RxInt  cantidad;

  ProductModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.cantidad
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      cantidad: 0.obs
    );
  }
}
