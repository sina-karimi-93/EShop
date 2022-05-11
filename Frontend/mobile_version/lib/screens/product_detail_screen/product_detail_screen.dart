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

  void _addCommentHandler() {
    /* This method gets the value of the textfield in modalbottomsheet
     and submit it to the comments of the products.*/
    String newComment = _commentController.text;
    print(newComment);
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
            padding: const EdgeInsets.all(8.0),
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
                      1.1,
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopify))
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
                    return Card(
                      elevation: 5,
                      child: Image.memory(
                        widget.product.images[index],
                        height: 100,
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
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '\$${widget.product.price}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ======================== SIZE AND COLOR ========================
              Row(
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
                              color: Colors.white,
                            )),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          dropdownColor: Theme.of(context).colorScheme.primary,
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
                        DropdownButton<String>(
                          dropdownColor: Theme.of(context).colorScheme.primary,
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
                        const Text(
                          " Color",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                ],
              ),

              const SizedBox(height: 20),
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
                      height: 500,
                      child: ListView.builder(
                        itemCount: widget.product.comments.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.secondary,
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
                                icon: Icon(Icons.edit,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
