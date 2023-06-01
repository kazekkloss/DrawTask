import 'dart:convert';

import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../blocs/blocs.dart';
import '../config/config.dart';
import '../models/models.dart';

class GameSocket {
  final _socketClient = SocketConnect.instance.socket!;
  Socket get socketConnect => _socketClient;

  // EMITTER

  void joinToGame({required BuildContext context}) {
    try {
      final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
      _socketClient
          .emit("joinToGame", {"currentUserId": authBloc.state.user.id});

      _socketClient.on("joinedToGame", (data) {
        final game = Game.fromJson(jsonEncode(data));

        // add game to list in block state
        context.read<GameBloc>().add(AddGameEvent(game: game));

        // turn off listener

        _socketClient.off('joinedToGame');

        // go to screen
        context.goNamed(RouteConstants.drawingScreen, extra: game);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // LISTENERS

  void setVoidName({required BuildContext context}) {
    try {} catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
