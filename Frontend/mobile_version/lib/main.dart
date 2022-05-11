import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Screens
import './screens/welcome_screen/welcome_screen.dart';
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
        home: const WelcomeScreen(),
      ),
    );
  }
}
