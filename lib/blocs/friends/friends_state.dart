part of 'friends_bloc.dart';

enum FriendsStatus { loading, loaded }

class FriendsState extends Equatable {
  final FriendsStatus status;
  final List<User> friends;
  final List<User> invitationsToMe;
  final List<User> invitationsFromMe;
  const FriendsState(
      {required this.status,
      required this.friends,
      required this.invitationsToMe,
      required this.invitationsFromMe});

  const FriendsState._(
      {this.status = FriendsStatus.loading,
      this.friends = const [],
      this.invitationsToMe = const [],
      this.invitationsFromMe = const []});

  const FriendsState.loading() : this._();

  const FriendsState.loaded(List<User> friends, List<User> invitationsToMe,
      List<User> invitationsFromMe)
      : this._(
            status: FriendsStatus.loaded,
            friends: friends,
            invitationsToMe: invitationsToMe,
            invitationsFromMe: invitationsFromMe);

  FriendsState copyWith({
    FriendsStatus? status,
    List<User>? friends,
    List<User>? invitationsToMe,
    List<User>? invitationsFromMe,
  }) {
    return FriendsState(
      status: status ?? this.status,
      friends: friends ?? this.friends,
      invitationsToMe: invitationsToMe ?? this.invitationsToMe,
      invitationsFromMe: invitationsFromMe ?? this.invitationsFromMe,
    );
  }

  @override
  List<Object> get props => [friends, invitationsToMe, invitationsFromMe];
}
