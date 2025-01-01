class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final bool isAdmin;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = false,
  });

  // Chuyển đổi từ Map sang User
  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    password: json['password'],
    isAdmin: json['isAdmin'] == 1,
  );

  // Chuyển đổi từ User sang Map
  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'email': email,
    'password': password,
    'isAdmin': isAdmin ? 1 : 0,
  };
}
