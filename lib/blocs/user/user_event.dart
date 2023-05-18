part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class GetUsersEvent extends UserEvent {
  final List<String> friends;
  final List<String> invitationsToMe;
  final List<String> invitationsFromMe;
  final BuildContext context;

  GetUsersEvent({
    required this.friends,
    required this.invitationsToMe,
    required this.invitationsFromMe,
    required this.context,
  });

  @override
  List<Object?> get props =>
      [friends, invitationsToMe, invitationsFromMe, context];
}

class SendInvitationEvent extends UserEvent {
  final BuildContext context;
  final String userId;

  SendInvitationEvent({required this.context, required this.userId});

  @override
  List<Object?> get props => [context];
}
