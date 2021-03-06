import 'package:flutter/widgets.dart';
import 'package:mobile_version/Models/cart.dart';

import 'provider_tools.dart';

class CartProvider with ChangeNotifier {
  var _cart;
  bool isLoaded = false;
  Cart get cart {
    return _cart;
  }

  Future<bool> fetchAndSetCart(String ownerId) async {
    /*
    This method gets user cart from server and reshape it
    to a readable way in flutter.
    */
    final response =
        await getDataFromServer("carts/$ownerId", {"ownerId": ownerId});
    if (response["status"] == "ok") {
      final userCart = response["userCart"];
      final List<Item> cartItems = [];
      for (Map<String, dynamic> item in userCart["items"]) {
        cartItems.add(
          Item(
              item: item["item"]["\$oid"],
              price: item["price"],
              count: item["count"],
              totalItemPrice: item["total_item_price"],
              color: item["color"],
              size: item["size"]),
        );
      }
      _cart = Cart(
          id: userCart["_id"]["\$oid"],
          owner: ownerId,
          items: cartItems,
          totalPrice: userCart["total_price"],
          totalCount: userCart["total_count"]);
      isLoaded = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void changeItemCount(String itemId, bool increase) {
    /*
    This method change amount of the item in a cart. Consequently,
    the total price of that item, and the overal price will be changed.
    Maximun number of each item is 10 and minimun is 1.
    */
    Item item =
        _cart.items.where((element) => element.item == itemId).toList().first;
    // ======================== Increase =======================
    if (increase) {
      if (item.count == 10) {
        return;
      }
      item.count += 1;
      item.totalItemPrice += item.price;
      _cart.totalCount += 1;
      _cart.totalPrice += item.price;
    }
    // ======================== Decrease =======================
    else {
      if (item.count == 1) {
        return;
      }
      item.count -= 1;
      item.totalItemPrice -= item.price;
      _cart.totalCount -= 1;
      _cart.totalPrice -= item.price;
    }
    // Dou to increasing decimals in multiplication we have to fix them by 2 decimal
    _cart.totalPrice = double.parse(_cart.totalPrice.toStringAsFixed(2));
    item.totalItemPrice = double.parse(item.totalItemPrice.toStringAsFixed(2));
    notifyListeners();
  }

  void removeItem(Item item) {
    /*
    This method removes an item from cart items and update
    totalCount and totalPrice fields.
    */
    cart.totalCount -= item.count;
    cart.totalPrice -= item.totalItemPrice;
    cart.items.remove(item);
    notifyListeners();
  }

  Future<void> updateCart() async {
    var items = [];
    // Turn each Item to a Map and add it to the items list
    cart.items.forEach(
      (element) => items.add({
        "item": {"\$oid": element.item},
        "count": element.count,
        "total_item_price": element.totalItemPrice,
        "price": element.price,
        "color": element.color,
        "size": element.size,
      }),
    );
    // Turn Cart to a Map
    Map<String, dynamic> updatedCart = {
      "owner": {"\$oid": cart.owner},
      "items": items,
      "total_price": cart.totalPrice,
      "total_count": cart.totalCount,
    };
    final response =
        await sendDataToServer("/carts/${_cart.owner}", updatedCart, "put");
  }

  Future<bool> addItem(
      {required String itemId,
      String color = "",
      String size = "",
      required double price}) async {
    /*
    This method add new item to the cart. If item is exists it will
    return false, otherwise it start the adding process.
    */
    // Check whether item exists or not
    bool isItemExists =
        _cart.items.where((element) => element.item == itemId).isNotEmpty;

    if (isItemExists == false) {
      Item item = Item(
        item: itemId,
        count: 1,
        price: price,
        totalItemPrice: price,
        color: color,
        size: size,
      );
      _cart.items.add(item);
      _cart.totalCount += 1;
      _cart.totalPrice += price;

      await updateCart();
      notifyListeners();
      return true;
    }
    return false;
  }
}
