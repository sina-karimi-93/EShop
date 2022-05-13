import 'package:flutter/material.dart';
import 'package:mobile_version/screens/products_category_screen/products_category_screen.dart';

import '../../widgets/animated_page_route.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.isPortrait,
    required this.size,
    required this.category,
  }) : super(key: key);

  final bool isPortrait;
  final Size size;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            AnimatedPageRoute(
              widget: ProductsCategoryScreen(category),
              alignment: Alignment.bottomCenter,
            ),
          );
        },
        child: CircleAvatar(
          maxRadius: isPortrait ? size.width * 0.085 : size.width * 0.06,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(90),
            ),
            child: Center(
                child: Text(
              category,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
