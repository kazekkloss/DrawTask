import 'dart:async';
import 'package:drawtask/blocs/auth/auth_bloc.dart';
import 'package:drawtask/config/route_constants.dart';
import 'package:drawtask/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final BuildContext context;
  AppRouter({required this.context});

  GoRouter _router() => GoRouter(
        debugLogDiagnostics: true,
        redirect: (context, state) {
          var status = context.read<AuthBloc>().state.status;
          switch (status) {
            case AuthStatus.unknown:
              return state.namedLocation(RouteConstants.splash);
            case AuthStatus.authenticated:
              return state.namedLocation(RouteConstants.home);
            case AuthStatus.unauthenticated:
              if (state.location == '/sign_in/sign_up') {
                return state.namedLocation(RouteConstants.signUp);
              } else {
                return state.namedLocation(RouteConstants.signIn);
              }
            case AuthStatus.notVerified:
              return state.namedLocation(RouteConstants.checkLink);
            case AuthStatus.noUsername:
              return state.namedLocation(RouteConstants.setUsername);
          }
        },
        refreshListenable: GoRouterRefreshBloc<AuthBloc, AuthState>(
            BlocProvider.of<AuthBloc>(context, listen: false)),
        routes: [
          GoRoute(
            name: RouteConstants.splash,
            path: '/splash',
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            name: RouteConstants.signIn,
            path: '/sign_in',
            builder: (context, state) => const SignInScreen(),
            routes: [
              GoRoute(
                name: RouteConstants.signUp,
                path: 'sign_up',
                builder: (context, state) => const SignUpScreen(),
              ),
            ],
          ),
          GoRoute(
            name: RouteConstants.checkLink,
            path: '/check_link',
            builder: (context, state) => const CheckLinkScreen(),
          ),
          GoRoute(
            name: RouteConstants.setUsername,
            path: '/set_username',
            builder: (context, state) => const SetUsernameScreen(),
          ),
          GoRoute(
            name: RouteConstants.home,
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
        ],
        errorPageBuilder: (context, state) {
          return const MaterialPage(
              child: Scaffold(
            body: Center(
              child: Text('Error route'),
            ),
          ));
        },
      );
  GoRouter get router => _router();
}

// Class to convert bloc stream for refreshListenable -----------------

class GoRouterRefreshBloc<BLOC extends BlocBase<STATE>, STATE>
    extends ChangeNotifier {
  GoRouterRefreshBloc(BLOC bloc) {
    _blocStream = bloc.stream.listen(
      (STATE _) => notifyListeners(),
    );
  }

  late final StreamSubscription<STATE> _blocStream;

  @override
  void dispose() {
    _blocStream.cancel();
    super.dispose();
  }
}
