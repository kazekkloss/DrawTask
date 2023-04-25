import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final int verify;
  final String? username;
  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.verify,
    this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'verify': verify,
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      verify: map['verify']?.toInt() ?? 0,
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? email,
    String? password,
    String? token,
    int? verify,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      verify: verify ?? this.verify,
      username: username ?? this.username,
    );
  }
}
