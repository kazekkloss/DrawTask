part of 'draw_bloc.dart';

class DrawState extends Equatable {
  final List<Sketch> listSketch;
  final Sketch sketch;

  const DrawState({required this.sketch, required this.listSketch});

  @override
  List<Object?> get props => [listSketch, sketch];
}