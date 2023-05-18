part of 'user_bloc.dart';

enum UsersStatus { loading, loaded }

class UserState extends Equatable {
  final UsersStatus status;
  final List<User> friends;
  final List<User> invitationsToMe;
  final List<User> invitationsFromMe;
  const UserState(
      {required this.status,
      required this.friends,
      required this.invitationsToMe,
      required this.invitationsFromMe});

  const UserState._(
      {this.status = UsersStatus.loading,
      this.friends = const [],
      this.invitationsToMe = const [],
      this.invitationsFromMe = const []});

  const UserState.loading() : this._();

  const UserState.loaded(List<User> friends, List<User> invitationsToMe,
      List<User> invitationsFromMe)
      : this._(
            status: UsersStatus.loaded,
            friends: friends,
            invitationsToMe: invitationsToMe,
            invitationsFromMe: invitationsFromMe);

  @override
  List<Object> get props => [friends, invitationsToMe, invitationsFromMe];
}
