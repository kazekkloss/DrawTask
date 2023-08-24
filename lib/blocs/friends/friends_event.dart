part of 'friends_bloc.dart';

enum FriendsType {
  accepted,
  waiting,
  invitations,
}

abstract class FriendsEvent extends Equatable {}

class GetFriendsEvent extends FriendsEvent {
  final int listLength;
  final FriendsType friendsType;
  final BuildContext context;
  GetFriendsEvent({
    required this.listLength,
    required this.friendsType,
    required this.context,
  });

  @override
  List<Object?> get props => [context, friendsType, listLength];
}


