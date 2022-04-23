import 'package:flutter/material.dart';

import 'home_screen_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  List<Widget> get homeScreenWidgets {
    return const [
      HomeScreenItem(image: './assets/images/shop1.jpg', title: 'SHOP'),
      HomeScreenItem(image: './assets/images/blog1.jpg', title: 'BLOG'),
      HomeScreenItem(
          image: './assets/images/ai1.jpg', title: 'FACE RECOGNITION'),
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
                  children: homeScreenWidgets,
                ))
              : GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  children: homeScreenWidgets,
                ),
        ),
      ),
    );
  }
}
