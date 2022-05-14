import 'package:flutter/material.dart';
import 'package:mobile_version/Constants/icons.dart';
import 'package:mobile_version/providers/user_provider.dart';
import 'package:mobile_version/screens/auth_screen/auth_screen.dart';
import 'package:mobile_version/screens/cart_screen.dart/cart_screen.dart';
import 'package:mobile_version/screens/home_screen/home_screen.dart';
import 'package:mobile_version/screens/shop_screen/shop_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/fancy_text.dart';
import '../Database/db_handler.dart';

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
                      GestureDetector(
                          onTap: () {
                            Provider.of<UserProvider>(context, listen: false)
                                .logoutUser()
                                .then(
                              (value) {
                                if (value) {
                                  Navigator.of(context)
                                      .pushNamed(AuthScreen.routeName);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Error"),
                                      content:
                                          const Text("Something went wrong"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("ok"))
                                      ],
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: const DrawerItems(
                              title: "Logout", icon: Icons.logout)),
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
    // final User user = Provider.of<UserProvider>(context).user;
    return DrawerHeader(
      padding: const EdgeInsets.all(0),
      child: Container(
        color: Colors.white,
        child: Center(
          child: FancyText(
            // text: "Enjoy your shop!\n${user.username}",
            text: "Enjoy your shop!",
            fontSize: 30,
            letterSpacing: 3,
            outlineColor: Theme.of(context).colorScheme.primary,
            inlineColor: Colors.amber[600],
          ),
        ),
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
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            // color: Theme.of(context).colorScheme.secondary,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
