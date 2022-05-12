import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Screens
// import './screens/welcome_screen/welcome_screen.dart';
import 'package:mobile_version/screens/home_screen/home_screen.dart';
import './screens/cart_screen.dart/cart_screen.dart';
import 'package:mobile_version/screens/shop_screen/shop_screen.dart';
// Providers
import './providers/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: const Color.fromRGBO(20, 35, 51, 1),
            secondary: Colors.deepOrange,
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          ShopScreen.routeName: (context) => const ShopScreen(),
          CartScreen.routeName: (context) => const CartScreen()
        },
      ),
    );
  }
}
