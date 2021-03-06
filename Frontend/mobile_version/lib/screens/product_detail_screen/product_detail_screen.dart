// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/Models/product.dart';
import 'package:mobile_version/Models/user.dart';
import 'package:mobile_version/providers/cart_provider.dart';
import 'package:mobile_version/providers/products_provider.dart';
import 'package:mobile_version/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../Constants/colors.dart';
import '../../Constants/icons.dart';
import './product_detail_images.dart';
import '../../widgets/card_items_count_badge.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var sizeDropDownValue;
  var colorDropDownValue;
  int colorSelector = 0;
  int sizeSelector = 0;
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool hasComments = widget.product.comments.isNotEmpty;
    final Size size = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    Provider.of<ProductsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.product.title),
        actions: const [
          CardItemsCountBadge(),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ======================== IMAGES =========================
              ProductDetailImages(size: size, images: widget.product.images),
              const SizedBox(height: 15),
              // ======================== TITLE and PRICE ========================
              ProductDetailTitlePrice(
                title: widget.product.title,
                price: widget.product.price,
              ),
              const SizedBox(height: 20),
              // ======================== SIZE AND COLOR ========================
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 2,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // SIZE
                    if (widget.product.sizes.isNotEmpty)
                      Row(
                        children: [
                          const Text("Sizes   ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: isPortrait
                                ? size.width * 0.75
                                : size.width * 0.85,
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.product.sizes.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        sizeSelector = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: sizeSelector == index
                                          ? Colors.orange
                                          : Colors.white,
                                      child: Text(
                                        widget.product.sizes[index][0],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    // =============== COLORS =================
                    if (widget.product.colors.isNotEmpty)
                      Row(
                        children: [
                          const Text(
                            "Colors ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: isPortrait
                                ? size.width * 0.75
                                : size.width * 0.85,
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.product.colors.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        colorSelector = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          colors[widget.product.colors[index]],
                                      child: colorSelector == index
                                          ? Icon(
                                              Icons.color_lens_outlined,
                                              color: colors[widget.product
                                                              .colors[index]] ==
                                                          Colors.white ||
                                                      colors[widget.product
                                                              .colors[index]] ==
                                                          Colors.yellow
                                                  ? Colors.black
                                                  : Colors.white,
                                              size: 25,
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
              // ======================== COMMENTS ========================
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Comments",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _addCommentModal(),
                child: const Text("Add new comment!",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              !hasComments
                  ? const SizedBox(
                      height: 50,
                      child: Center(
                          child: Text(
                        "There is not any comments!",
                        style: TextStyle(color: Colors.white),
                      )),
                    )
                  : SizedBox(
                      height: isPortrait ? 300 : 180,
                      child: ListView.builder(
                        itemCount: widget.product.comments.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  Text(widget.product.comments[index].username),
                                ],
                              ),
                              title:
                                  Text(widget.product.comments[index].comment),
                              subtitle: Text(
                                DateFormat.yMMMd().format(
                                    widget.product.comments[index].createDate),
                              ),
                              trailing: user.username ==
                                      widget.product.comments[index].username
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => _removeComment(
                                          widget.product.comments[index]),
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToCard,
        child: Icon(
          shopping_cart,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

// =============================== METHODS ====================================
// =============================== METHODS ====================================
// =============================== METHODS ====================================
// =============================== METHODS ====================================
// =============================== METHODS ====================================
// =============================== METHODS ====================================
// =============================== METHODS ====================================
// =============================== METHODS ====================================
// =============================== METHODS ====================================

  Future<void> _removeComment(Comment comment) async {
    /*
    This method is responsible for removing a comment.
    */
    print("Delete comment Clicked");
    bool result = await Provider.of<ProductsProvider>(context, listen: false)
        .removeComment(widget.product.id, comment);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Comment successfully ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                "deleted",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _addToCard() async {
    /*
    This method stands for collecting data which user selected
    for this product and add it to the cards.
    */

    final isAdded =
        await Provider.of<CartProvider>(context, listen: false).addItem(
      itemId: widget.product.id,
      price: widget.product.price,
      color: widget.product.colors.isNotEmpty
          ? widget.product.colors[colorSelector]
          : "",
      size: widget.product.sizes.isNotEmpty
          ? widget.product.sizes[sizeSelector]
          : "",
    );

    // Showing relative Snackbar Message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.product.title} ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              isAdded
                  ? "has been added to the card"
                  : " is currently in your cart",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addCommentHandler() async {
    /* This method gets the value of the textfield in modalbottomsheet
     and submit it to the comments of the products.*/
    String newComment = _commentController.value.text;

    User user = Provider.of<UserProvider>(context, listen: false).user;

    bool result = await Provider.of<ProductsProvider>(context, listen: false)
        .addNewComment(
      newComment,
      widget.product.id,
      user.serverId,
      user.username,
    );
    if (result) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong!"),
        ),
      );
    }
  }

  void _addCommentModal() {
    /*
    This method open a modalbottomsheet to user add a new comment for this product.
    */
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50.0))),
        context: context,
        builder: (ctx) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 20, left: 8, right: 8),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  const Center(
                      child: Text(
                    "Please write your comment",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      focusColor: Colors.red,
                      fillColor: Colors.red,
                      hoverColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      label: const Text('Comment'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom) *
                        1.08,
                    child: ElevatedButton(
                      onPressed: _addCommentHandler,
                      child: const Text("Submit"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class ProductDetailTitlePrice extends StatelessWidget {
  const ProductDetailTitlePrice({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  final String title;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          Text(
            '\$$price',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
