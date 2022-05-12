import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:mobile_version/providers/products_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        Provider.of<ProductsProvider>(context, listen: false).products[1];
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 3,
            color: Colors.orange,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ======================== Image and Title ========================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.memory(
                product.images[0],
                height: size.width * 0.3,
                width: size.width * 0.3,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Flexible(
                  child: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
          const Divider(),
          // ======================== Info ========================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                "\$${product.price}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                "\$150",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Count",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                      )),
                ],
              ),
              Text(
                "5",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Remove",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
