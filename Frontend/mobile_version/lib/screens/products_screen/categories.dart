import 'package:flutter/material.dart';

import 'category_item.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.isPortrait,
    required this.size,
    required this.categories,
  }) : super(key: key);

  final bool isPortrait;
  final Size size;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isPortrait ? size.height * 0.15 : size.height * 0.3,
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
