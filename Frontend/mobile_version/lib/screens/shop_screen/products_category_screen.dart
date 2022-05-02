import 'package:flutter/material.dart';

class ProductsCategoryScreen extends StatelessWidget {
  final String category_name;

  const ProductsCategoryScreen(this.category_name, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(category_name),
      ),
    );
  }
}
