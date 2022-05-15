import 'package:flutter/material.dart';
import 'package:mobile_version/providers/cart_provider.dart';
import 'package:mobile_version/providers/user_provider.dart';
import 'package:mobile_version/screens/cart_screen.dart/cart_screen.dart';
import 'package:provider/provider.dart';

import '../Models/user.dart';

class CardItemsCountBadge extends StatelessWidget {
  const CardItemsCountBadge({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).user;
    final cartData = Provider.of<CartProvider>(context);
    if (cartData.isLoaded == false) {
      cartData.fetchAndSetCart(user.serverId);
    }
    return !cartData.isLoaded
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: 15,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: const Icon(
                    (Icons.shopify),
                    size: 35,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    maxRadius: 10,
                    child: Text(
                      cartData.cart.totalCount.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
