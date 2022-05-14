import 'package:flutter/material.dart';
import 'package:mobile_version/Constants/icons.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import '../../widgets/shop_app_drawer.dart';
import '../../widgets/waiting_screen.dart';
import '../../Models/cart.dart';
import '../../Models/product.dart';
import '../../Models/user.dart';
import '../../providers/cart_provider.dart';
import '../../providers/user_provider.dart';
import './cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = './carts';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoaded = false;
  bool _isUpdated = true;
  @override
  void initState() {
    final User user = Provider.of<UserProvider>(context, listen: false).user;
    Provider.of<CartProvider>(context, listen: false)
        .fetchAndSetCart(user.serverId)
        .then((value) => setState(() {
              _isLoaded = true;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    if (!_isLoaded) {
      return const WaitingScreen();
    } else {
      final cartData = Provider.of<CartProvider>(context);
      final cart = cartData.cart;
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        drawer: ShopAppDrawer(size: size, isPortrait: isPortrait),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cart',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            _isUpdated
                ? IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      setState(() {
                        _isUpdated = false;
                      });
                      cartData.updateCart().then((value) {
                        setState(() {
                          _isUpdated = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.done,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Your cart has beeen successfully updated!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
            IconButton(
              icon: Icon(
                shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 2,
                      color: Theme.of(context).colorScheme.secondary),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        "\$${cart.totalPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items count",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        "${cart.totalCount}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, index) {
                    Product product =
                        Provider.of<ProductsProvider>(context, listen: false)
                            .findProductById(cart.items[index].item);
                    return Dismissible(
                      key: Key(cart.items[index].item),
                      direction: DismissDirection.endToStart,
                      onDismissed: (value) {
                        cartData.removeItem(cart.items[index]);
                      },
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            title: const Text("Warning!"),
                            content: const Text(
                                "Are you sure you want to remove this item from your cart?"),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("No")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Yes")),
                            ],
                          ),
                        );
                      },
                      background: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Icon(
                            Icons.delete,
                            color: Colors.amber,
                            size: 40,
                          ),
                        ),
                      ),
                      child: CartItem(
                        cartItem: cart.items[index],
                        product: product,
                      ),
                    );
                  }),
            )
          ],
        ),
      );
    }
  }
}
