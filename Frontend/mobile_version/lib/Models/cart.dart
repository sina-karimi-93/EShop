class Cart {
  Cart({
    required this.id,
    required this.owner,
    required this.items,
    required this.totalPrice,
    required this.totalCount,
  });
  String id;
  String owner;
  List<Item> items;
  double totalPrice;
  int totalCount;
}

class Item {
  Item({
    required this.item,
    required this.price,
    required this.count,
    this.color = "",
    this.size = "",
    required this.totalItemPrice,
  });
  String item;
  double price;
  String color;
  String size;
  int count;
  double totalItemPrice;
}
