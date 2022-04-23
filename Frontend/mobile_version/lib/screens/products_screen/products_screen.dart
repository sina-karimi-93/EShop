import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:mobile_version/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isProductsLoaded = false;

  @override
  void didChangeDependencies() {
    Provider.of<ProductsProvider>(context)
        .prepareProducts()
        .then((_) => setState(() {
              _isProductsLoaded = true;
            }));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products =
        Provider.of<ProductsProvider>(context).products;

    return Scaffold(
      appBar: AppBar(),
      body: !_isProductsLoaded
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: []),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
