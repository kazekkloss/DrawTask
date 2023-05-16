import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../config/config.dart';
import '../models/models.dart';
import 'sockets.dart';

class UserSocket {
  final _socketClient = SocketConnect.instance.socket!;
  Socket get socketConnect => _socketClient;

  Future<User> sendInvitation(
      {required BuildContext context, required String userId}) async {
    User user = User.empty;
    try {
      _socketClient.emit('sendInvitation', userId);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return user;
  }
}
