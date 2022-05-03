import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:intl/intl.dart';
import '../../widgets/animated_page_route.dart';
import '../product_detail_screen/product_detail_screen.dart';

class ProductCategoryItem extends StatelessWidget {
  final Product product;

  const ProductCategoryItem({
    required this.product,
    Key? key,
  }) : super(key: key);

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
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(spreadRadius: 3, blurRadius: 5, color: Colors.blueGrey)
            ]),
        child: ListTile(
          onTap: () => _gestureOnTap(context),
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.memory(
                  product.images[0],
                  fit: BoxFit.contain,
                )),
          ),
          title: Text(
            product.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          subtitle: Text(DateFormat.yMMMd().format(product.createDate)),
          trailing: Text(
            '\$${product.price}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
