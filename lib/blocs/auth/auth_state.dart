part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  notVerified,
  noUsername,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;
  const AuthState({required this.user, required this.status});

  const AuthState._({this.status = AuthStatus.unknown, this.user = User.empty});

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.notVerified(User user)
      : this._(status: AuthStatus.notVerified, user: user);

   const AuthState.noUsername(User user)
       : this._(status: AuthStatus.noUsername, user: user);

  @override
  List<Object> get props => [status, user];

  static void of(BuildContext context) {}
}
