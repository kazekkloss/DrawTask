import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState.loading()) {
    on<AddGamesEvent>(_addGamesToState);
    on<AddGameEvent>(_addGameToState);
    on<DeleteGameEvent>(_deleteGameToState);
    on<UpdateGameEvent>(_updateGameToState);
    on<ClearGamesEvent>(_clearEventToState);
  }

  void _addGamesToState(AddGamesEvent event, Emitter<GameState> emit) {
    try {
      List<Game> updatedGames = List.from(state.games)..addAll(event.games);

      emit(GameState.loaded(updatedGames));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _addGameToState(AddGameEvent event, Emitter<GameState> emit) {
    try {
      List<Game> updatedGames = List.from(state.games)..add(event.game);

      emit(GameState.loaded(updatedGames));

      // for (var game in state.games) {
      //   print('Game ID: ${game.id}');
      //   print('Game Words: ${game.gameWords}');
      //   for (var picture in game.pictures) {
      //     print(' - Picture ID: ${picture.id}');
      //     print(' - imageUrl: ${picture.imageUrl}');
      //   }
      // }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _deleteGameToState(DeleteGameEvent event, Emitter<GameState> emit) {
    try {
      List<Game> updatedGames = List.from(state.games)
        ..removeWhere((game) => game.id == event.gameId);

      emit(GameState.loaded(updatedGames));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _updateGameToState(UpdateGameEvent event, Emitter<GameState> emit) {
    try {
      List<Game> updatedGames = List.from(state.games);

      int gameIndex =
          updatedGames.indexWhere((game) => game.id == event.game.id);

      if (gameIndex != -1) {
        updatedGames[gameIndex] = event.game;
      } else {
        // Jeśli nie ma gry o podanym identyfikatorze, dodaj nową do listy
        updatedGames.add(event.game);
      }
      emit(state.copyWith(games: updatedGames));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _clearEventToState(
      ClearGamesEvent event, Emitter<GameState> emit) async {
    try {
      emit(const GameState.loading());
    } catch (e) {
      debugPrint('$e');
    }
  }
}
