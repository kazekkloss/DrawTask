import 'package:drawtask/config/config.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/vote.dart';

class VotesSocket {
  final _socketClient = SocketConnect.instance.socket!;
  Socket get socketConnect => _socketClient;

  void addVotes(
      {required BuildContext context,
      required List<Vote> votes,
      required String gameId,
      required String userIdVoice}) async {
    try {
      for (var vote in votes) {
        print(
            'id: ${vote.id}, point: ${vote.point}');
      }

      _socketClient.emit("addVote", {
        "gameId": gameId,
        "votes": votes,
        "userIdVoice": userIdVoice,
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
