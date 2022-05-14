class User {
  User({
    required this.localId,
    required this.id,
    required this.username,
    required this.email,
  });

  final int localId;
  final String id;
  final String username;
  final String email;
}
