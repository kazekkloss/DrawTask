import 'dart:convert';

class Game {
  final String id;
  final List<String> gameWords;
  final List<String> users;

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
      users: List<String>.from(map['users']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));

  Game copyWith({
    String? id,
    List<String>? gameWords,
    List<String>? users,
  }) {
    return Game(
      id: id ?? this.id,
      gameWords: gameWords ?? this.gameWords,
      users: users ?? this.users,
    );
  }
}
