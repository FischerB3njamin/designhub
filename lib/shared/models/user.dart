class User {
  String email;
  String password;
  late String userId;

  User({required this.email, required this.password}) {
    userId = createUserId();
  }

  String createUserId() {
    return "a";
  }
}
