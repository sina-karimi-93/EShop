import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/Models/product.dart';
import './provider_tools.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  List<String> _categories = [];
  bool isLoaded = false;
  List<Product> get products {
    return [..._products];
  }

  List<String> get categories {
    return [..._categories];
  }

  void _prepareCategories(loadedCategories) {
    /*
    After getting categories from the server, we push them
    into a list as strings.
    */
    try {
      _categories = [];
      for (String element in loadedCategories["categories"]!) {
        _categories.add(element);
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List<Uint8List> _convertBinariesToImages(var binaryImages) {
    /* 
    This method converts images from binary base64 to Uint8List. In this
    way we can use these in Image.memory() widget to show
    these images in the app.

    args:
        binaryImages -> List of binary base64 
        [
          {
            "$binary": { "base64" : "..." }
          }
        ]
    */

    List<Uint8List> imagesUints = [];

    for (var imageData in binaryImages) {
      Uint8List imageUint = base64Decode(imageData['\$binary']['base64']);
      imagesUints.add(imageUint);
    }
    return imagesUints;
  }

  void _prepareProducts(var loadedProducts) {
    /*
    After getting products from server, it is time to
    reshape them as a usable objects in the app. So, we
    use Product class as a container. See ./Models/product.dart.
    */
    _products = [];
    for (var product in loadedProducts) {
      List<Comment> comments = [];
      product["comments"].forEach((comment) {
        comments.add(
          Comment(
            id: comment["id"]["\$oid"],
            comment: comment["comment"],
            ownerId: comment["owner"]["\$oid"],
            username: comment["username"],
            createDate: DateFormat("yyyy-MM-dd")
                .parse(comment["create_date"]["\$date"]),
          ),
        );
      });
      _products.add(
        Product(
          id: product["_id"]["\$oid"],
          title: product["title"],
          description: product["description"],
          price: product["price"],
          createDate:
              DateFormat("yyyy-MM-dd").parse(product["create_date"]["\$date"]),
          categories: product["categories"],
          colors: product["colors"],
          sizes: product["sizes"],
          images: _convertBinariesToImages(product["images"]),
          comments: comments,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> prepareProductsData() async {
    /*
    This method called from shop screen and get data from
    server. For that screen we need all products and categories.
    So, via _getDataFromServer() method we get the required data
    and pass them to related methods to reshape them for using
    in the app.
    */

    try {
      var loadedProducts = await getDataFromServer('/products', {});
      var loadedCategories =
          await getDataFromServer('/products/categories', {});
      _prepareProducts(loadedProducts);
      _prepareCategories(loadedCategories);
    } catch (error) {
      rethrow;
    }
  }

  List<Product> getSameProductsInCategory(String category) {
    /*
    This method return all products which they are 
    in same desired category.
    */
    List<Product> sameProducts = products.where((product) {
      return product.categories.contains(category);
    }).toList();
    return sameProducts;
  }

  Product findProductById(String id) {
    /*
    Find a single product based on its id.

    args:
      id
    */
    final Product product =
        products.where((element) => element.id == id).toList().first;
    return product;
  }

  Future<bool> addNewComment(
      String comment, String productId, String userId, String username) async {
    /*
    This method adds new comment to specific product. 
    args:
      comment -> user comment for that product
      productId -> product id
      userID -> comment owner id
    */
    final data = {
      "comment": comment,
      "owner": userId,
      "username": username,
    };
    final response =
        await sendDataToServer("/products/$productId/comments", data, "post");
    if (response["status"] == "ok") {
      final newComment = response["comment"];
      final Product product =
          _products.where((element) => element.id == productId).toList().first;
      product.comments.add(
        Comment(
            id: newComment["id"]["\$oid"],
            comment: newComment["comment"],
            ownerId: newComment["owner"]["\$oid"],
            username: newComment["username"],
            createDate: DateFormat("yyyy-MM-dd")
                .parse(newComment["create_date"]["\$date"])),
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> removeComment(Comment comment) async {}
}
