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

      for (var game in state.games) {
        print('Game ID: ${game.id}');
        print('Game Words: ${game.gameWords}');
        for (var picture in game.pictures) {
          print(' - Picture ID: ${picture.id}');
          print(' - imageUrl: ${picture.imageUrl}');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _changePictureToToState(
      ChangePictureEvent event, Emitter<GameState> emit) {
    try {
      final List<Game> updatedGames = state.games.map((game) {
        final List<Picture> updatedPictures = game.pictures.map((picture) {
          if (picture.id == event.picture.id) {
            return event.picture;
          } else {
            return picture;
          }
        }).toList();

        return game.copyWith(pictures: updatedPictures);
      }).toList();

      emit(state.copyWith(games: updatedGames));

      for (var game in state.games) {
        print('Game ID: ${game.id}');
        print('Game Words: ${game.gameWords}');
        for (var picture in game.pictures) {
          print(' - Picture ID: ${picture.id}');
          print(' - imageUrl: ${picture.imageUrl}');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
