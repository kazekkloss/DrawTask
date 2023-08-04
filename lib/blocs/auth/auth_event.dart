part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class SignUpEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  SignUpEvent(
      {required this.context, required this.email, required this.password});

  @override
  List<Object?> get props => [context, email, password];
}

class SignInEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  SignInEvent(
      {required this.context, required this.email, required this.password});

  @override
  List<Object?> get props => [context, email, password];
}

class CheckAuthEvent extends AuthEvent {
  final BuildContext context;

  CheckAuthEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class LogoutEvent extends AuthEvent {
  final BuildContext context;

  LogoutEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class SaveUsernameEvent extends AuthEvent {
  final BuildContext context;
  final String username;
  final String avatar;

  SaveUsernameEvent({required this.context, required this.username, required this.avatar});

  @override
  List<Object?> get props => [context, username, avatar];
}
