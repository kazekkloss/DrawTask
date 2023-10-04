part of 'drawings_bloc.dart';

enum DrawingsStatus { loading, loaded }

class DrawingsState extends Equatable {
  final DrawingsStatus status;
  final List<Drawing> myDrawings;
  final List<Drawing> wallDrawings;
  const DrawingsState(
      {required this.status,
      required this.myDrawings, required this.wallDrawings});

  const DrawingsState._(
      {this.status = DrawingsStatus.loading,
      this.myDrawings = const [],
      this.wallDrawings = const []});

  const DrawingsState.loading() : this._();

  const DrawingsState.loaded(List<Drawing> myDrawings, List<Drawing> wallDrawings)
      : this._(
            status: DrawingsStatus.loaded,
            myDrawings: myDrawings,
            wallDrawings: wallDrawings);

  DrawingsState copyWith({
    DrawingsStatus? status,
    List<Drawing>? myDrawings,
    List<Drawing>? wallDrawings
  }) {
    return DrawingsState(
      status: status ?? this.status,
      myDrawings: myDrawings ?? this.myDrawings,
      wallDrawings: wallDrawings ?? this.wallDrawings,
    );
  }

  @override
  List<Object> get props => [status, myDrawings, wallDrawings];
}