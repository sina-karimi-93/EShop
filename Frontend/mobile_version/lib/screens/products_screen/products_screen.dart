import 'package:flutter/material.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:mobile_version/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'categories.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isProductsLoaded = false;

  @override
  void didChangeDependencies() {
    Provider.of<ProductsProvider>(context).prepareProducts();
    Provider.of<ProductsProvider>(context)
        .prepareAllCategories()
        .then((value) => setState(() {
              _isProductsLoaded = true;
            }));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products =
        Provider.of<ProductsProvider>(context).products;

    final List<String> categories =
        Provider.of<ProductsProvider>(context).categories;

    final Size size = MediaQuery.of(context).size;

    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: !_isProductsLoaded
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Divider(),
                    Categories(
                      isPortrait: isPortrait,
                      size: size,
                      categories: categories,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Products",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.all(15),
                                color: Colors.white,
                                child: GridTile(
                                  child: Text(products[index].title),
                                ));
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
