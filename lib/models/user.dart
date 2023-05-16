import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final int verify;
  final String? username;
  final List<String>? invitationsToMe;
  final List<String>? invitationsFromMe;
  final List<String>? friendsList;
  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.verify,
    this.username,
    this.invitationsToMe,
    this.invitationsFromMe,
    this.friendsList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'verify': verify,
      'username': username,
      'invitationsToMe': invitationsToMe,
      'invitationsFromMe': invitationsFromMe,
      'friendsList': friendsList,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      verify: map['verify']?.toInt() ?? 0,
      username: map['username'] ?? '',
      invitationsToMe: List<String>.from(map['invitationsToMe'] ?? []),
      invitationsFromMe: List<String>.from(map['invitationsFromMe'] ?? []),
      friendsList: List<String>.from(map['friendsList'] ?? []),
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
    List<String>? invitationsToMe,
    List<String>? invitationsFromMe,
    List<String>? friendsList,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      verify: verify ?? this.verify,
      username: username ?? this.username,
      invitationsToMe: invitationsToMe ?? this.invitationsToMe,
      invitationsFromMe: invitationsFromMe ?? this.invitationsFromMe,
      friendsList: friendsList ?? this.friendsList,
    );
  }

  static const empty = User(id: '', email: '', password: '', verify: 0);
}
