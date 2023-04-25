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
        super(AuthInitializing()) {
    on<SignUpEvent>(_signUpEventToState);
    on<SignInEvent>(_signInEventToState);
    on<UserProviderEvent>(_onUserProviderEventToState);
  }

  void _signUpEventToState(SignUpEvent event, Emitter<AuthState> emit) {
    try {
      _authRepository.signUp(
          context: event.context, email: event.email, password: event.password);
      emit(AuthLoading());
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _signInEventToState(SignInEvent event, Emitter<AuthState> emit) {
    try {
      _authRepository.signIn(
          context: event.context, email: event.email, password: event.password);
      emit(AuthLoading());
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _onUserProviderEventToState(
      UserProviderEvent event, Emitter<AuthState> emit) {
    try {
      print(event.token);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
