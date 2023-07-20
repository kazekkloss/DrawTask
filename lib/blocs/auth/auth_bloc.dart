import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drawtask/blocs/draw/draw_bloc.dart';
import 'package:drawtask/blocs/game/game_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    on<SignUpEvent>(_signUpEventToState);
    on<SignInEvent>(_signInEventToState);
    on<SaveUsernameEvent>(_saveUsernameEventToState);
    on<CheckAuthEvent>(_onCheckAuthEventToState);
    on<LogoutEvent>(_onLogoutEventToState);
  }

  void _signUpEventToState(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      User user = await _authRepository.signUp(
          context: event.context, email: event.email, password: event.password);
      AuthState state = await userChecker(user);
      emit(state);
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _signInEventToState(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      User user = await _authRepository.signIn(
          context: event.context, email: event.email, password: event.password);
      print("sign in in block - ${user.username}");
      AuthState state = await userChecker(user);
      emit(state);
      print("state - ${state.user.username}");
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _saveUsernameEventToState(
      SaveUsernameEvent event, Emitter<AuthState> emit) async {
    try {
      User user = await _authRepository.setUsername(
          context: event.context, username: event.username);
      if (user != User.empty) {
        AuthState state = await userChecker(user);
        emit(state);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _onCheckAuthEventToState(
      CheckAuthEvent event, Emitter<AuthState> emit) async {
    try {
      User user = await _authRepository.getUserData(context: event.context);
      AuthState newState = await userChecker(user);
      if (state.status == AuthStatus.notVerified) {
        if (state.user.verify != user.verify) {
          emit(newState);
        }
      } else {
        emit(newState);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _onLogoutEventToState(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      User user = await _authRepository.logout(context: event.context);
      if (user == User.empty) {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  // This is a middleware function that is used to emit the proper states
  Future<AuthState> userChecker(User user) async {
    AuthState state = const AuthState.unknown();
    try {
      if (user != User.empty) {
        if (user.verify == 0) {
          state = AuthState.notVerified(user);
        } else if (user.username!.isEmpty) {
          state = AuthState.noUsername(user);
        } else {
          state = AuthState.authenticated(user);
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      debugPrint('$e');
    }
    return state;
  }
}
