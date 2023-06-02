import 'dart:convert';

import 'package:drawtask/models/models.dart';

class Game {
  final String id;
  final List<String> gameWords;
  final List<User> users;

  Game({
    required this.id,
    required this.gameWords,
    required this.users,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameWords': gameWords,
      'users': users,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['_id'] ?? '',
      gameWords: List<String>.from(map['gameWords']),
      users: List<User>.from(
        map['users']?.map(
          (x) => User.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));

  Game copyWith({
    String? id,
    List<String>? gameWords,
    List<User>? users,
  }) {
    return Game(
      id: id ?? this.id,
      gameWords: gameWords ?? this.gameWords,
      users: users ?? this.users,
    );
  }
}
