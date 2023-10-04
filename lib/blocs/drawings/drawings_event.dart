part of 'drawings_bloc.dart';

abstract class DrawingsEvent extends Equatable {}

class GetMyDrawingsEvent extends DrawingsEvent {
  final BuildContext context;
  GetMyDrawingsEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class GetWallDrawingsEvent extends DrawingsEvent {
  final BuildContext context;
  GetWallDrawingsEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
