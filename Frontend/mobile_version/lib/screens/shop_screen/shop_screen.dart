import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../screens/shop_screen/products.dart';
import 'categories.dart';
import '../../widgets/shop_app_drawer.dart';

class ShopScreen extends StatefulWidget {
  static const routeName = './shop_screen';

  const ShopScreen({Key? key}) : super(key: key);
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool _isLoading = false;

  // @override
  // void initState() {
  //   Provider.of<ProductsProvider>(context, listen: false)
  //       .prepareProductsData()
  //       .then((value) => {
  //             setState((() {
  //               _isLoading = false;
  //             }))
  //           });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    Provider.of<ProductsProvider>(context, listen: false).prepareProductsData();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      drawer: ShopAppDrawer(size: size, isPortrait: isPortrait),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<ProductsProvider>(context, listen: false)
                        .prepareProductsData();
                  },
                  child: Column(
                    children: [
                      Categories(isPortrait: isPortrait, size: size),
                      const SizedBox(height: 10),
                      const Products(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
