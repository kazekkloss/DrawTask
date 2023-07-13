import 'dart:convert';

class Voice {
  final String id;
  final String userVoice;
  final int point;

  Voice({required this.id, required this.userVoice, required this.point});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userVoice': userVoice,
      'point': point,
    };
  }

  factory Voice.fromMap(Map<String, dynamic> map) {
    return Voice(
      id: map['_id'] ?? '',
      userVoice: map['userVoice'],
      point: map['point']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Voice.fromJson(String source) => Voice.fromMap(json.decode(source));

  Voice copyWith({String? id, String? userVoice, int? point}) {
    return Voice(
      id: id ?? this.id,
      userVoice: userVoice ?? this.userVoice,
      point: point ?? this.point,
    );
  }
}