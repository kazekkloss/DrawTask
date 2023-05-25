part of 'user_bloc.dart';

enum UsersStatus { loading, loaded }

class UsersState extends Equatable {
  final UsersStatus status;
  final List<User> friends;
  final List<User> invitationsToMe;
  final List<User> invitationsFromMe;
  const UsersState(
      {required this.status,
      required this.friends,
      required this.invitationsToMe,
      required this.invitationsFromMe});

  const UsersState._(
      {this.status = UsersStatus.loading,
      this.friends = const [],
      this.invitationsToMe = const [],
      this.invitationsFromMe = const []});

  const UsersState.loading() : this._();

  const UsersState.loaded(List<User> friends, List<User> invitationsToMe,
      List<User> invitationsFromMe)
      : this._(
            status: UsersStatus.loaded,
            friends: friends,
            invitationsToMe: invitationsToMe,
            invitationsFromMe: invitationsFromMe);

  UsersState copyWith({
    UsersStatus? status,
    List<User>? friends,
    List<User>? invitationsToMe,
    List<User>? invitationsFromMe,
  }) {
    return UsersState(
      status: status ?? this.status,
      friends: friends ?? this.friends,
      invitationsToMe: invitationsToMe ?? this.invitationsToMe,
      invitationsFromMe: invitationsFromMe ?? this.invitationsFromMe,
    );
  }

  @override
  List<Object> get props => [friends, invitationsToMe, invitationsFromMe];
}
