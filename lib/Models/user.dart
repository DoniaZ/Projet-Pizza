class User {
  final String email;
  final String password;
  final String role;

  User({
    required this.email,
    required this.password,
    this.role = "bad526d9-bc5a-45f1-9f0b-eafadcd4fc15",
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
