part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class SendInvitationEvent extends UserEvent {
  final BuildContext context;
  final String userId;

  SendInvitationEvent({required this.context, required this.userId});

  @override
  List<Object?> get props => [context];
}
