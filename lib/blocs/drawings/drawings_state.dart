part of 'drawings_bloc.dart';

enum DrawingsStatus { loading, loaded }

class DrawingsState extends Equatable {
  final DrawingsStatus status;
  final List<Drawing> myDrawings;
  const DrawingsState({required this.myDrawings, required this.status});

  const DrawingsState._(
      {this.status = DrawingsStatus.loading, this.myDrawings = const []});

  const DrawingsState.loading() : this._();

  const DrawingsState.loaded(List<Drawing> myDrawings)
      : this._(status: DrawingsStatus.loaded, myDrawings: myDrawings);

  DrawingsState copyWith({DrawingsStatus? status, List<Drawing>? myDrawings}) {
    return DrawingsState(
        myDrawings: myDrawings ?? this.myDrawings,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [myDrawings, status];
}
