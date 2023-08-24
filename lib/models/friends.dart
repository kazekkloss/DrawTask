import 'dart:convert';


class Friends {
  final List<String> invitationsToMe;
  final List<String> invitationsFromMe;
  final List<String> friends;

  const Friends({
    required this.invitationsToMe,
    required this.invitationsFromMe,
    required this.friends,
  });

  Map<String, dynamic> toMap() {
    return {
      'invitationsToMe': invitationsToMe,
      'invitationsFromMe': invitationsFromMe,
      'friends': friends,
    };
  }

  factory Friends.fromMap(Map<String, dynamic> map) {
    return Friends(
      invitationsToMe: List<String>.from(map['invitationsToMe'] ?? []),
      invitationsFromMe: List<String>.from(map['invitationsFromMe'] ?? []),
      friends: List<String>.from(map['friends'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Friends.fromJson(String source) =>
      Friends.fromMap(json.decode(source));

  Friends copyWith({
    String? id,
    String? email,
    String? password,
    String? token,
    int? verify,
    List<String>? invitationsToMe,
    List<String>? invitationsFromMe,
    List<String>? friends,
    String? username,
    String? avatar,
  }) {
    return Friends(
      invitationsToMe: invitationsToMe ?? this.invitationsToMe,
      invitationsFromMe: invitationsFromMe ?? this.invitationsFromMe,
      friends: friends ?? this.friends,
    );
  }

  static const empty =
      Friends(invitationsToMe: [], invitationsFromMe: [], friends: []);
}
