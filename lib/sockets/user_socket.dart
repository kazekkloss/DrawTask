import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../blocs/blocs.dart';
import '../config/config.dart';
import '../models/models.dart';
import 'sockets.dart';

class UserSocket {
  final _socketClient = SocketConnect.instance.socket!;
  Socket get socketConnect => _socketClient;

  // Send invitation to user ---------------------------------------------------
  Future<User> sendInvitation(
      {required BuildContext context, required String userId}) async {
    final completer = Completer<User>();
    try {
      final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
      _socketClient.emit('sendInvitation',
          {'currentUserId': authBloc.state.user.id, 'otherUserId': userId});

      Timer timeoutTimer;
      const timeoutDuration = Duration(seconds: 5);
      timeoutTimer = Timer(timeoutDuration, () {
        completer.complete(User.empty);
      });

      _socketClient.on('sendInvitationSuccess', (data) {
        timeoutTimer.cancel();
        User newUser = User.fromMap(data);
        completer.complete(newUser);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      completer.completeError(e);
    }

    return completer.future;
  }
}
