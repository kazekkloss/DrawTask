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
    on<ChangePictureEvent>(_changePictureToToState);
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

  void _changePictureToToState(
      ChangePictureEvent event, Emitter<GameState> emit) {
    try {
      final List<Game> updatedGames = state.games.map((game) {
        if (game.id == event.gameId) {
          final List<Picture> updatedPictures = game.pictures.map((picture) {
            if (picture.id == event.picture.id) {
              return event.picture;
            } else {
              return picture;
            }
          }).toList();

          if (!updatedPictures
              .any((picture) => picture.id == event.picture.id)) {
            updatedPictures.add(event.picture);
          }

          return game.copyWith(pictures: updatedPictures);
        } else {
          return game;
        }
      }).toList();

      emit(state.copyWith(games: updatedGames));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
