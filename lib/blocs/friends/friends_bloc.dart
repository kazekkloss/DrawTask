import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final FriendsRepository _friendsRepository;
  FriendsBloc({required FriendsRepository friendsRepository})
      : _friendsRepository = friendsRepository,
        super(const FriendsState.loading()) {
    on<GetFriendsEvent>(_getUsersEventToState);
  }

  void _getUsersEventToState(
      GetFriendsEvent event, Emitter<FriendsState> emit) async {
    List<User> usersList = await _friendsRepository.getUsersList(
        context: event.context,
        friendsType: event.friendsType);
    try {
      if (event.friendsType == FriendsType.accepted) {
        if (event.listLength != 0) {
          List<User> updatedList = List.from(state.friends)..addAll(usersList);
          emit(state.copyWith(
              status: FriendsStatus.loaded, friends: updatedList));
        } else {
          emit(
              state.copyWith(status: FriendsStatus.loaded, friends: usersList));
        }
      } 
      if (event.friendsType == FriendsType.waiting) {
        if (event.listLength != 0) {
          List<User> updatedList = List.from(state.invitationsFromMe)
            ..addAll(usersList);
          emit(state.copyWith(
              status: FriendsStatus.loaded, invitationsFromMe: updatedList));
        } else {
          emit(state.copyWith(
              status: FriendsStatus.loaded, invitationsFromMe: usersList));
        }
      } 
      if (event.friendsType == FriendsType.invitations) {
        if (event.listLength != 0) {
          List<User> updatedList = List.from(state.invitationsToMe)
            ..addAll(usersList);
          emit(state.copyWith(
              status: FriendsStatus.loaded, invitationsToMe: updatedList));
        } else {
          emit(state.copyWith(
              status: FriendsStatus.loaded, invitationsToMe: usersList));
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
