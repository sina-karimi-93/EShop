import 'package:flutter/material.dart';

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
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(90),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary,
                  blurRadius: 4,
                  spreadRadius: 3,
                )
              ]),
          width: isPortrait ? size.width * 0.25 : size.width * 0.15,
          height: isPortrait ? size.height * 0.2 : size.height * 0.15,
          child: Center(
              child: Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          )),
        ),
      ),
    );
  }
}
