import 'package:flutter/material.dart';
import '../../providers/products_provider.dart';
import '../../screens/shop_screen/products.dart';
import 'package:provider/provider.dart';

import 'categories.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  Future<void> initializeData() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context)
          .prepareProductsData()
          .then((_) => setState(
                () {
                  _isLoading = false;
                },
              ));
    }
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
                    Categories(isPortrait: isPortrait, size: size),
                    const SizedBox(height: 10),
                    const Products(),
                  ],
                ),
              ),
            ),
    );
  }
}
