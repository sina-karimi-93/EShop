class Product {
  late final String id;
  late final String title;
  late final double price;
  late final String description;
  late final DateTime createDate;
  late final List<dynamic> sizes;
  late final List<dynamic> colors;
  late final List<dynamic> categories;
  late final List<dynamic> images;
  late final List<Comment> comments;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.createDate,
    required this.sizes,
    required this.colors,
    required this.categories,
    required this.images,
    required this.comments,
  });

  void removeComment(String id) {
    comments.removeWhere((cm) => cm.id == id);
  }
}

class Comment {
  Comment({
    required this.id,
    required this.comment,
    required this.ownerId,
    required this.username,
    required this.createDate,
  });
  final String id;
  final String comment;
  final String ownerId;
  final String username;
  final DateTime createDate;
}
