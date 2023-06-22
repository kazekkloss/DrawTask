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

class ChangePictureEvent extends GameEvent {
  final String gameId;
  final Picture picture;
  ChangePictureEvent({
    required this.gameId,
    required this.picture,
  });

  @override
  List<Object?> get props => [picture];
}
