import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:mobile_version/screens/product_detail_screen/product_detail_screen.dart';

import '../../widgets/animated_page_route.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {Key? key}) : super(key: key);

  void _gestureOnTap(context) {
    Navigator.push(
      context,
      AnimatedPageRoute(
        widget: ProductDetailScreen(product),
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => _gestureOnTap(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GridTile(
              header: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                height: 28,
                color: Colors.black87.withOpacity(0.9),
                child: Center(
                    child: Text(
                  product.title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )),
              ),
              child: Image.memory(product.images[0], fit: BoxFit.fill),
              footer: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                height: 28,
                color: Colors.black87.withOpacity(0.8),
                child: Center(
                    child: Text(
                  "\$${product.price}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
