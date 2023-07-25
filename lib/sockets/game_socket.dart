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

  // --------------------------------------------------------------------------------------
  void getAllGames({required BuildContext context}) {
    try {
      List<Game> gamesList = [];
      final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
      _socketClient
          .emit("getAllGames", {"currentUserId": authBloc.state.user.id});

      _socketClient.on("allGamesToState", (data) {
        print(data);
        for (var gameData in data) {
          gamesList.add(Game.fromMap(gameData));
        }
        context.read<GameBloc>().add(AddGamesEvent(games: gamesList));
        _socketClient.off('allGamesToState');
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

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
        context.goNamed(RouteConstants.drawingScreen, extra: game);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // LISTENERS

  void gameOnListener(BuildContext context) async {
    try {
      print('game listener');
      _socketClient.on("gameListener", (data) {
        final game = Game.fromJson(jsonEncode(data));
        context.read<GameBloc>().add(UpdateGameEvent(game: game));
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void gameOffListener(BuildContext context) {
    try {
      print("game listener off");
      _socketClient.off("gameListener");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  // --------------------------------------------------------------------------------------
}
