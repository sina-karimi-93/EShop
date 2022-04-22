import 'package:flutter/widgets.dart';

class Product {
  late final String id;
  late final String title;
  late final double price;
  late final String description;
  late final DateTime createDate;
  late final List<dynamic> sizes;
  late final List<dynamic> colors;
  late final List<dynamic> categories;
  late final List<dynamic> images;
  late final List<dynamic> comments;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.createDate,
    required this.sizes,
    required this.colors,
    required this.categories,
    required this.comments,
  });
}
