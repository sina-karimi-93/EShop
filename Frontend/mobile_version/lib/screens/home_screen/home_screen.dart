import 'package:flutter/material.dart';
import 'package:mobile_version/providers/products_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    Provider.of<ProductsProvider>(context).prepareProducts().then((_) {
      setState(() {
        _isLoaded = true;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;
    return Scaffold(
      body: !_isLoaded
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, index) => Column(
                children: [
                  Text(products[index].title),
                ],
              ),
            ),
    );
  }
}
