// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/Models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var sizeDropDownValue;
  var colorDropDownValue;
  final _commentController = TextEditingController();
  static const IconData shopping_cart =
      IconData(0xe59c, fontFamily: 'MaterialIcons');

  void _removeComment(Map<String, dynamic> comment) {
    /*
    This method is responsible for removing a comment.
    */
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

  void _addToCard() {
    /*
    This method stands for collecting data which user selected
    for this product and add it to the cards.
    */

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
            const Text(
              "has been added to the card",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addCommentHandler() {
    /* This method gets the value of the textfield in modalbottomsheet
     and submit it to the comments of the products.*/
    String newComment = _commentController.text;
    Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    bool hasComments = widget.product.comments.isNotEmpty;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.product.title),
        actions: [
          Container(
            child: const Icon(
              (Icons.shopify),
            ),
          ),
          const SizedBox(width: 10),
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
              SizedBox(
                height: size.height * 0.4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.product.images.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 3,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      child: Image.memory(
                        widget.product.images[index],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 15),
              // ======================== TITLE and PRICE ========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          '${widget.product.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                child: Row(
                  mainAxisAlignment: widget.product.sizes.isNotEmpty
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (widget.product.sizes.isNotEmpty)
                      Row(
                        children: [
                          const Text("Size ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            dropdownColor:
                                Theme.of(context).colorScheme.primary,
                            iconEnabledColor:
                                Theme.of(context).colorScheme.secondary,
                            value: sizeDropDownValue,
                            items: widget.product.sizes
                                .map<DropdownMenuItem<String>>((var size) {
                              return DropdownMenuItem<String>(
                                value: size,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    size,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                sizeDropDownValue = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    if (widget.product.colors.isNotEmpty)
                      Row(
                        children: [
                          const Text(
                            "Color ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          DropdownButton<String>(
                            dropdownColor:
                                Theme.of(context).colorScheme.primary,
                            iconEnabledColor:
                                Theme.of(context).colorScheme.secondary,
                            value: colorDropDownValue,
                            items: widget.product.colors
                                .map<DropdownMenuItem<String>>((var size) {
                              return DropdownMenuItem<String>(
                                value: size,
                                child: Text(
                                  size,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                colorDropDownValue = value!;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
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
                child: const Text("Add new comment!"),
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
                      height: 300,
                      child: ListView.builder(
                        itemCount: widget.product.comments.length,
                        itemBuilder: (ctx, index) {
                          return Dismissible(
                            key: Key(
                                widget.product.comments[index]['id']['\$oid']),
                            background: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (event) => _removeComment(widget
                                .product
                                .comments[index] as Map<String, dynamic>),
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                title: Text(
                                    widget.product.comments[index]["message"]),
                                subtitle: Text(
                                  DateFormat.yMMMd().format(
                                    DateFormat("yyyy-MM-dd").parse(
                                        widget.product.comments[index]
                                            ["create_date"]["\$date"]),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  onPressed: () => _removeComment(
                                      widget.product.comments[index]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
            // ======================== RELATED PRODUCTS ========================
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToCard,
        child: const Icon(shopping_cart),
      ),
    );
  }
}
