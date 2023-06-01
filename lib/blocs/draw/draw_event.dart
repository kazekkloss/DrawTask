part of 'draw_bloc.dart';

abstract class DrawEvent {}

class OnStartEvent extends DrawEvent {
  final BuildContext context;
  final DragStartDetails details;
  OnStartEvent({required this.details, required this.context});
}

class OnUpdateEvent extends DrawEvent {
  final BuildContext context;
  final DragUpdateDetails details;
  OnUpdateEvent({required this.details, required this.context});
}

class OnEndEvent extends DrawEvent {
  final BuildContext context;
  final DragEndDetails details;
  OnEndEvent({required this.details, required this.context});
}

class SkechWidthEvent extends DrawEvent {
  final double width;
  SkechWidthEvent({required this.width});
}

class ChangeColorEvent extends DrawEvent {
  final Color color;
  ChangeColorEvent({required this.color});
}

class ChangeModeEvent extends DrawEvent {
  final DrawingMode mode;
  ChangeModeEvent({required this.mode});
}

class SetFillEvent extends DrawEvent {
  final bool filled;
  SetFillEvent({required this.filled});
}

class UndoEvent extends DrawEvent {}

class ClearEvent extends DrawEvent {}