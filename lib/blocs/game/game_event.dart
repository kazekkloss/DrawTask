part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {}

class AddGamesEvent extends GameEvent {
  final List<Game> games;
  AddGamesEvent({
    required this.games,
  });

  @override
  List<Object?> get props => [games];
}

class ClearGamesEvent extends GameEvent {
  ClearGamesEvent();

  @override
  List<Object?> get props => [];
}

class AddGameEvent extends GameEvent {
  final Game game;
  AddGameEvent({
    required this.game,
  });

  @override
  List<Object?> get props => [game];
}

class DeleteGameEvent extends GameEvent {
  final String gameId;
  DeleteGameEvent({
    required this.gameId,
  });

  @override
  List<Object?> get props => [gameId];
}

class UpdateGameEvent extends GameEvent {
  final Game game;
  UpdateGameEvent({
    required this.game,
  });

  @override
  List<Object?> get props => [game];
}
