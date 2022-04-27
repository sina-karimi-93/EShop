import 'package:flutter/material.dart';
import 'package:mobile_version/screens/blogs_screen/blogs_screen.dart';
import 'package:mobile_version/screens/face_recognition_screen/face_recognition_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import '../../widgets/animated_page_route.dart';
import '../products_screen/products_screen.dart';

import 'home_screen_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  List<Widget> homeScreenWidgets(context) {
    return [
      HomeScreenItem(
        image: './assets/images/shop1.jpg',
        title: 'SHOP',
        navigatorHandler: () {
          Navigator.push(
            context,
            AnimatedPageRoute(
              widget: const ProductsScreen(),
              alignment: Alignment.bottomCenter,
            ),
          );
        },
      ),
      HomeScreenItem(
        image: './assets/images/blog1.jpg',
        title: 'BLOG',
        navigatorHandler: () {
          Navigator.push(
            context,
            AnimatedPageRoute(
              widget: const BlogsScreen(),
              alignment: Alignment.bottomCenter,
            ),
          );
        },
      ),
      HomeScreenItem(
        image: './assets/images/ai1.jpg',
        title: 'FACE RECOGNITION',
        navigatorHandler: () {
          Navigator.push(
            context,
            AnimatedPageRoute(
              widget: const FaceRecognitionScreen(),
              alignment: Alignment.bottomCenter,
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.03, horizontal: size.width * 0.03),
          child: isPortrait
              ? SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: homeScreenWidgets(context),
                ))
              : GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  children: homeScreenWidgets(context),
                ),
        ),
      ),
    );
  }
}
