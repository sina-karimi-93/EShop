import 'package:flutter/material.dart';
import 'package:mobile_version/Constants/icons.dart';
import 'package:mobile_version/screens/cart_screen.dart/cart_screen.dart';
import 'package:mobile_version/screens/home_screen/home_screen.dart';
import 'package:mobile_version/screens/shop_screen/shop_screen.dart';

class ShopAppDrawer extends StatelessWidget {
  final Size size;
  final bool isPortrait;

  const ShopAppDrawer({
    required this.size,
    required this.isPortrait,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isPortrait
          ? BorderRadius.only(
              topRight: Radius.circular(size.width * 0.2),
              bottomRight: Radius.circular(size.width * 0.2),
            )
          : BorderRadius.only(
              topRight: Radius.circular(size.width * 0.06),
              bottomRight: Radius.circular(size.width * 0.06),
            ),
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const CustomDrawerHeader(),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        child: const DrawerItems(
                          title: "Home",
                          icon: Icons.home,
                        ),
                        onTap: () => Navigator.of(context)
                            .pushNamed(HomeScreen.routeName),
                      ),
                      const Divider(),
                      GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(ShopScreen.routeName),
                          child: const DrawerItems(
                              title: "Shop", icon: shopping_cart)),
                      GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(CartScreen.routeName),
                          child: const DrawerItems(
                              title: "Carts", icon: Icons.shopify)),
                      const DrawerItems(
                          title: "Orders", icon: Icons.monetization_on_sharp),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.all(0),
      child: Container(
        color: Colors.white,
        child: Center(
            child: Stack(
          children: <Widget>[
            // Stroked text as border.
            Text(
              'Enjoy Your Shop!',
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = Theme.of(context).colorScheme.primary,
              ),
            ),
            // Solid text as fill.
            Text(
              'Enjoy Your Shop!',
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                color: Colors.amber[600],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  final String title;
  final IconData icon;

  const DrawerItems({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            // color: Theme.of(context).colorScheme.secondary,
            color: Colors.orange,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.orange,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(
          Icons.arrow_right,
          color: Colors.orange,
        ),
      ),
    );
  }
}
