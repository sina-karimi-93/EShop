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
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '\$${widget.product.price}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ======================== SIZE ========================
              const Text(
                'Size',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.orange),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.sizes.join(", "),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // ======================== COLORS ========================
              const Text(
                "Colors",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.orange),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.colors.join(', '),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                          leading: const Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          title:
                              Text(widget.product.comments[index]["message"]),
                          subtitle: Text(DateFormat.yMMMd().format(
                              DateFormat("yyyy-MM-dd").parse(widget.product
                                  .comments[index]["create_date"]["\$date"]))),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
