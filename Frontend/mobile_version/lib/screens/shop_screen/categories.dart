import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import 'category_item.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.isPortrait,
    required this.size,
  }) : super(key: key);

  final bool isPortrait;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final List<String> categories =
        Provider.of<ProductsProvider>(context).categories;
    return SizedBox(
      height: isPortrait ? size.height * 0.1 : size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: ((context, index) {
          String category = categories[index];
          return CategoryItem(
              isPortrait: isPortrait, size: size, category: category);
        }),
      ),
    );
  }
}
