import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          child: GridTile(
            header: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              height: 28,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
              child: Center(
                  child: Text(
                "\$${product.price.toString()}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            child: Center(
                child: Icon(
              Icons.shopify,
              size: 50,
              color: Theme.of(context).colorScheme.secondary,
            )),
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
    );
  }
}
