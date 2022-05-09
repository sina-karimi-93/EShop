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
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Comments",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
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
                        title: Text(widget.product.comments[index]["message"]),
                        subtitle: Text(
                          DateFormat.yMMMd().format(
                            DateFormat("yyyy-MM-dd").parse(widget.product
                                .comments[index]["create_date"]["\$date"]),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit,
                              color: Theme.of(context).colorScheme.secondary),
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
