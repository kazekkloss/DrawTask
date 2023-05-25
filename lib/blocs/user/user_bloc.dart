import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UsersBloc extends Bloc<UserEvent, UsersState> {
  final UserRepository _userRepository;
  UsersBloc(
      {required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UsersState.loading()) {
    on<SendInvitationEvent>(_sendInvitationEventToState);
    on<GetUsersEvent>(_getUsersEventToState);
    on<ConfirmInvitationEvent>(_confirmInvitationEvenToState);
    on<DeleteUserEvent>(_deleteUserEventToState);
  }

  void _getUsersEventToState(
      GetUsersEvent event, Emitter<UsersState> emit) async {
    try {
      if (event.friendsType == FriendsType.accepted) {
        List<User> usersList = await _userRepository.getUsersList(
            context: event.context,
            currentListLength: event.listLength,
            friendsType: event.friendsType);

        if (event.listLength != 0) {
          List<User> updatedList = List.from(state.friends)..addAll(usersList);
          emit(
              state.copyWith(status: UsersStatus.loaded, friends: updatedList));
        } else {
          emit(state.copyWith(status: UsersStatus.loaded, friends: usersList));
        }
      } else if (event.friendsType == FriendsType.waiting) {
        List<User> usersList = await _userRepository.getUsersList(
            context: event.context,
            currentListLength: event.listLength,
            friendsType: event.friendsType);

        if (event.listLength != 0) {
          List<User> updatedList = List.from(state.invitationsFromMe)
            ..addAll(usersList);
          emit(state.copyWith(
              status: UsersStatus.loaded, invitationsFromMe: updatedList));
        } else {
          emit(state.copyWith(
              status: UsersStatus.loaded, invitationsFromMe: usersList));
        }
      } else if (event.friendsType == FriendsType.invitations) {
        List<User> usersList = await _userRepository.getUsersList(
            context: event.context,
            currentListLength: event.listLength,
            friendsType: event.friendsType);

        if (event.listLength != 0) {
          List<User> updatedList = List.from(state.invitationsToMe)
            ..addAll(usersList);
          emit(state.copyWith(
              status: UsersStatus.loaded, invitationsToMe: updatedList));
        } else {
          emit(state.copyWith(
              status: UsersStatus.loaded, invitationsToMe: usersList));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _deleteUserEventToState(
      DeleteUserEvent event, Emitter<UsersState> emit) async {
    try {
      _userRepository.deleteFriend(
          context: event.context,
          userId: event.userId,
          currentListLength: state.invitationsFromMe.length,
          friendsType: event.friendsType);

      if (event.friendsType == FriendsType.accepted) {
        List<User> updatedList = List.from(state.friends);
        updatedList.removeWhere((user) => user.id == event.userId);

        emit(state.copyWith(
          friends: updatedList,
        ));
      } else if (event.friendsType == FriendsType.waiting) {
        List<User> updatedList = List.from(state.invitationsFromMe);
        updatedList.removeWhere((user) => user.id == event.userId);

        print(updatedList.length);

        emit(state.copyWith(
          invitationsFromMe: updatedList,
        ));
      } else if (event.friendsType == FriendsType.invitations) {
        List<User> updatedList = List.from(state.invitationsToMe);
        updatedList.removeWhere((user) => user.id == event.userId);

        emit(state.copyWith(
          invitationsToMe: updatedList,
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  void _sendInvitationEventToState(
      SendInvitationEvent event, Emitter<UsersState> emit) async {
    try {
      User user = await _userRepository.sendInvitation(
          context: event.context, userId: event.userId);
      if (user != User.empty) {
        final UsersState currentState = state;
        List<User> updatedInvitationsFromMe =
            List.from(currentState.invitationsFromMe)..insert(0, user);
        emit(currentState.copyWith(
          invitationsFromMe: updatedInvitationsFromMe,
        ));
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _confirmInvitationEvenToState(
      ConfirmInvitationEvent event, Emitter<UsersState> emit) async {
    try {
      User user = await _userRepository.confirmInvitation(
          context: event.context, userId: event.userId);
      if (user != User.empty) {
        List<User> updatedInvitationsToMe = List.from(state.invitationsToMe);

        updatedInvitationsToMe.removeWhere((user) => user.id == event.userId);

        List<User> updatedFriends = List.from(state.invitationsFromMe)
          ..insert(0, user);

        emit(state.copyWith(
          friends: updatedFriends,
          invitationsToMe: updatedInvitationsToMe,
        ));
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
