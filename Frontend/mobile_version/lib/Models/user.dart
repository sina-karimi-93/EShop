class User {
  User({
    required this.localId,
    required this.serverId,
    required this.username,
    required this.email,
    required this.password,
  });

  final int localId;
  final String serverId;
  final String username;
  final String email;
  final String password;
}
