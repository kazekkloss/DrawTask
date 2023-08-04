import 'dart:convert';


class Drawing {
  final String id;
  final String imageUrl;
  final List<String> gameWords;

  Drawing({
    required this.id,
    required this.imageUrl,
    required this.gameWords,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'gameWords': gameWords,
    };
  }

  factory Drawing.fromMap(Map<String, dynamic> map) {
    return Drawing(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      gameWords: List<String>.from(map['gameWords']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Drawing.fromJson(String source) =>
      Drawing.fromMap(json.decode(source));

  Drawing copyWith({
    String? id,
    String? imageUrl,
    List<String>? gameWords,
  }) {
    return Drawing(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      gameWords: gameWords ?? this.gameWords,
    );
  }
}
