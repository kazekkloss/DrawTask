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
        super(UserInitial()) {
    on<SendInvitationEvent>(_sendInvitationEventToState);
  }

  void _sendInvitationEventToState(
      SendInvitationEvent event, Emitter<UserState> emit) async {
    try {
      User user = await _userSocket.sendInvitation(
          context: event.context, userId: event.userId);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
