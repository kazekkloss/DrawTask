import 'dart:convert';

import 'package:drawtask/models/models.dart';

class Game {
  final String id;
  final List<String> gameWords;
  final List<User> users;
  final List<Picture> pictures;

  Game({
    required this.id,
    required this.gameWords,
    required this.users,
    required this.pictures,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameWords': gameWords,
      'users': users,
      'pictures': pictures,
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
      pictures: List<Picture>.from(
        map['pictures']?.map(
          (x) => Picture.fromMap(x),
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
    List<Picture>? pictures,
  }) {
    return Game(
      id: id ?? this.id,
      gameWords: gameWords ?? this.gameWords,
      users: users ?? this.users,
      pictures: pictures ?? this.pictures,
    );
  }
}
