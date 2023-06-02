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
