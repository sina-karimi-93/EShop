import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/Models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: size.height * 0.4,
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.images.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      elevation: 5,
                      child: Image.memory(
                        product.images[index],
                        height: 100,
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87),
            ),
            const SizedBox(height: 25),
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepOrange),
            ),
            const SizedBox(height: 20),
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
              product.sizes.join(", "),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
              product.colors.join(', '),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
                  itemCount: product.comments.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        title: Text(product.comments[index]["message"]),
                        subtitle: Text(DateFormat.yMMMd().format(
                            DateFormat("yyyy-MM-dd").parse(product
                                .comments[index]["create_date"]["\$date"]))),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
