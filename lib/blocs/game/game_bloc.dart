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
        super(const GameState.loading()) {
    on<AddGamesEvent>(_addGamesToState);
    on<AddGameEvent>(_addGameToState);
  }

  void _addGamesToState(AddGamesEvent event, Emitter<GameState> emit) {
    try {
      List<Game> updatedGames = List.from(state.games)..addAll(event.games);

      emit(GameState.loaded(updatedGames));
      print(state.games.length);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _addGameToState(AddGameEvent event, Emitter<GameState> emit) {
    try {
      List<Game> updatedGames = List.from(state.games)..add(event.game);

      emit(GameState.loaded(updatedGames));
      print(state.games.length);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
