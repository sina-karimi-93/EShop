import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

import '../../Models/product.dart';
import '../../providers/products_provider.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final productsData = Provider.of<ProductsProvider>(context);
    final List<Product> products = productsData.products;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isPortrait ? 2 : 3,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(products[index]);
        },
      ),
    );
  }
}
