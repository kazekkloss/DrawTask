part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {}

class AddGameEvent extends GameEvent {
  final Game game;
  AddGameEvent({
    required this.game,
  });

  @override
  List<Object?> get props => [game];
}
