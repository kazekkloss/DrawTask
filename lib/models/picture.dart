import 'dart:convert';

import 'models.dart';

class Picture {
  final String? id;
  final String imageUrl;
  final User userOwner;
  final int points;

  Picture({
    this.id,
    required this.imageUrl,
    required this.userOwner,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'userOwner': userOwner,
      'points': points,
    };
  }

  factory Picture.fromMap(Map<String, dynamic> map) {
    return Picture(
      id: map['_id'] ?? '',
      imageUrl: map['imageUrl'],
      userOwner: User.fromMap(map['userOwner']),
      points: map['points']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Picture.fromJson(String source) =>
      Picture.fromMap(json.decode(source));

  Picture copyWith({
    String? id,
    String? imageUrl,
    User? userOwner,
    int? points,
  }) {
    return Picture(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      userOwner: userOwner ?? this.userOwner,
      points: points ?? this.points,
    );
  }

  static Picture empty =
      Picture(imageUrl: '', userOwner: User.empty, points: 0);
}
