import 'dart:convert';

import 'package:bloc/bloc.dart';
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
    on<CheckAuthEvent>(_onCheckAuthEventToState);
  }

  void _signUpEventToState(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      User user = await _authRepository.signUp(
          context: event.context, email: event.email, password: event.password);
      if (user != User.empty) {
        emit(AuthState.notVerified(user));
      } else {
        emit(const AuthState.error());
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _signInEventToState(SignInEvent event, Emitter<AuthState> emit) {
    try {
      _authRepository.signIn(
          context: event.context, email: event.email, password: event.password);
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future _onCheckAuthEventToState(
      CheckAuthEvent event, Emitter<AuthState> emit) async {
    try {} catch (e) {
      debugPrint('$e');
    }
  }
}
