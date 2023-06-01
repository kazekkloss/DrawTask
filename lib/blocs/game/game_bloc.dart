import 'package:bloc/bloc.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameSocket _gameSocket;
  GameBloc({required GameSocket gameSocket})
      : _gameSocket = gameSocket,
        super(GameInitial()) {
    on<AddGameEvent>(_addGameToState);
  }

  void _addGameToState(AddGameEvent event, Emitter<GameState> emit) {
    try {
      print('event: ${event.game}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}
