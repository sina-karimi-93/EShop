import 'package:flutter/material.dart';
import 'package:mobile_version/providers/products_provider.dart';
import 'package:mobile_version/screens/products_screen/products.dart';
import 'package:provider/provider.dart';

import 'categories.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  Future<void> initializeData() async {
    // if (_isInit) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    Provider.of<ProductsProvider>(context)
        .prepareProductsData()
        .then((_) => setState(
              () {
                _isLoading = false;
              },
            ));
    // }
    _isInit = false;
  }

  @override
  void didChangeDependencies() {
    initializeData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    initializeData().then((_) {});
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _isLoading
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
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Products",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Divider(),
                    const Products(),
                  ],
                ),
              ),
            ),
    );
  }
}
