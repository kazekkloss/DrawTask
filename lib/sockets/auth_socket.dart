import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../config/config.dart';
import 'socket_connect.dart';

class AuthSocket {
  final _socketClient = SocketConnect.instance.socket!;
  Socket get socketConnect => _socketClient;

  // --------------------------------------------------------------------------------------
  void authSocket({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      _socketClient.connect();
      _socketClient.emit('authToSocket', userId);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void disconnectSocket({required BuildContext context}) async {
    try {
      _socketClient.disconnect();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
