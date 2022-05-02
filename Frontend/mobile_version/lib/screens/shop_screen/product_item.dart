import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:mobile_version/screens/product_detail_screen/product_detail_screen.dart';

import '../../widgets/animated_page_route.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              AnimatedPageRoute(
                widget: ProductDetailScreen(product),
                alignment: Alignment.bottomCenter,
              ),
            );
          },
          child: Container(
            color: Colors.white,
            child: GridTile(
              header: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                height: 28,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                child: Center(
                    child: Text(
                  // "\$${product.price.toString()}",
                  "${product.images[0]}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
              child: Image.asset("product.images[0]"),
              footer: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                height: 28,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                child: Center(
                    child: Text(
                  product.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
