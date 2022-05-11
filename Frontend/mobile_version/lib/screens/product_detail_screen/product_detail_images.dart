import 'package:flutter/material.dart';

class ProductDetailImages extends StatelessWidget {
  const ProductDetailImages({
    Key? key,
    required this.size,
    required this.images,
  }) : super(key: key);

  final Size size;
  final List<dynamic> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 3,
                  color: Colors.red,
                ),
              ],
            ),
            child: Image.memory(
              images[index],
            ),
          );
        }),
      ),
    );
  }
}
