import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:mobile_version/providers/products_provider.dart';
import 'package:mobile_version/screens/products_category_screen/product_category_item.dart';
import 'package:provider/provider.dart';

class ProductsCategoryScreen extends StatelessWidget {
  final String categoryName;

  const ProductsCategoryScreen(this.categoryName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final List<Product> products =
        productsData.getSameProductsInCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: ((context, index) {
              return ProductCategoryItem(
                product: products[index],
              );
            })),
      ),
    );
  }
}
