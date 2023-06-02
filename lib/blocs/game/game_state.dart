part of 'game_bloc.dart';

enum GameStatus { loading, loaded }

class GameState extends Equatable {
  final GameStatus status;
  final List<Game> games;
  const GameState({required this.games, required this.status});

  const GameState._({this.status = GameStatus.loading, this.games = const []});

  const GameState.loading() : this._();

  const GameState.loaded(List<Game> games)
      : this._(status: GameStatus.loaded, games: games);

  GameState copyWith({GameStatus? status, List<Game>? games}) {
    return GameState(games: games ?? this.games, status: status ?? this.status);
  }

  @override
  List<Object> get props => [games, status];
}
