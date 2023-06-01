part of 'user_bloc.dart';

enum FriendsType {
  accepted,
  waiting,
  invitations,
}

abstract class UserEvent extends Equatable {}

class GetUsersEvent extends UserEvent {
  final int listLength;
  final FriendsType friendsType;
  final BuildContext context;
  GetUsersEvent({
    required this.listLength,
    required this.friendsType,
    required this.context,
  });

  @override
  List<Object?> get props => [context, friendsType, listLength];
}

class SendInvitationEvent extends UserEvent {
  final BuildContext context;
  final String userId;

  SendInvitationEvent({required this.context, required this.userId});

  @override
  List<Object?> get props => [context, userId];
}

class DeleteUserEvent extends UserEvent {
  final BuildContext context;
  final String userId;
  final FriendsType friendsType;

  DeleteUserEvent(
      {required this.context,
      required this.userId,
      required this.friendsType});

  @override
  List<Object?> get props => [context, userId, friendsType];
}

class ConfirmInvitationEvent extends UserEvent {
  final BuildContext context;
  final String userId;

  ConfirmInvitationEvent({required this.context, required this.userId});

  @override
  List<Object?> get props => [context, userId];
}
