import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../../sockets/sockets.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final UserSocket _userSocket;
  UserBloc(
      {required UserRepository userRepository, required UserSocket userSocket})
      : _userRepository = userRepository,
        _userSocket = userSocket,
        super(const UserState.loading()) {
    on<SendInvitationEvent>(_sendInvitationEventToState);
    on<GetUsersEvent>(_getFriendsEventToState);
  }

  void _getFriendsEventToState(
      GetUsersEvent event, Emitter<UserState> emit) async {
    final BuildContext context = event.context;
    List<User> friends = [];
    List<User> invitationsToMe = [];
    List<User> invitationsFromMe = [];
    if (context.mounted) {
      friends = await _userRepository.getUserList(
          context: event.context, list: event.friends);
    }
    if (context.mounted) {
      invitationsToMe = await _userRepository.getUserList(
          context: event.context, list: event.invitationsToMe);
    }
    if (context.mounted) {
      invitationsFromMe = await _userRepository.getUserList(
          context: event.context, list: event.invitationsFromMe);
    }

    print(friends);
    print(invitationsFromMe);
    print(invitationsToMe);
    emit(UserState.loaded(friends, invitationsToMe, invitationsFromMe));
  }

  void _sendInvitationEventToState(
      SendInvitationEvent event, Emitter<UserState> emit) async {
    try {
      User user = await _userSocket.sendInvitation(
          context: event.context, userId: event.userId);
      if (user != User.empty) {
        print('is not empty: ${user.email}');
      } else {
        print('is empty');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
