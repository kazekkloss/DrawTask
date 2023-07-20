import 'dart:convert';

class Vote {
  final String id;
  final int point;

  Vote({required this.id, required this.point});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'point': point,
    };
  }

  factory Vote.fromMap(Map<String, dynamic> map) {
    return Vote(
      id: map['_id'] ?? '',
      point: map['point']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vote.fromJson(String source) => Vote.fromMap(json.decode(source));

  Vote copyWith({String? id, String? userVoice, int? point}) {
    return Vote(
      id: id ?? this.id,
      point: point ?? this.point,
    );
  }
}