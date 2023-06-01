import 'package:drawtask/models/game.dart';
import 'package:drawtask/screens/main/user_screen.dart';
import 'package:drawtask/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/blocs.dart';
import '../../models/user.dart';
import '../../screens/main/widgets/bottom_nav_bar.dart';
import '../config.dart';

class AppRouter {
  final BuildContext context;
  AppRouter({required this.context});

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  // The previous state is needed to check if it is the same as the current state in order to redirect the user.
  late AuthStatus previousStatus = AuthStatus.unknown;

  // Tabs for bottom navigation bar
  final tabs = [
    const NavBarItem(
        initialLocation: '/home', icon: Icon(Icons.home), label: ''),
    const NavBarItem(
        initialLocation: '/games', icon: Icon(Icons.dashboard), label: ''),
    const NavBarItem(
        initialLocation: '/new_game', icon: Icon(Icons.games), label: ''),
    const NavBarItem(
        initialLocation: '/profile', icon: Icon(Icons.person), label: ''),
  ];

  GoRouter _router() => GoRouter(
        //debugLogDiagnostics: true,
        navigatorKey: _rootNavigatorKey,
        redirect: (context, state) {
          var status = context.read<AuthBloc>().state.status;
          switch (status) {
            case AuthStatus.unknown:
              return state.namedLocation(RouteConstants.splash);
            case AuthStatus.authenticated:
              if (previousStatus != status) {
                previousStatus = status;
                return state.namedLocation(RouteConstants.home);
              } else {
                return null;
              }
            case AuthStatus.unauthenticated:
              if (previousStatus != status) {
                previousStatus = status;
                return state.namedLocation(RouteConstants.signIn);
              } else {
                return null;
              }
            case AuthStatus.notVerified:
              return state.namedLocation(RouteConstants.checkLink);
            case AuthStatus.noUsername:
              return state.namedLocation(RouteConstants.setUsername);
          }
        },
        refreshListenable: RouterRefreshBloc<AuthBloc, AuthState>(
            BlocProvider.of<AuthBloc>(context, listen: false)),
        routes: [
          // Auth screens ----------------------------------------------
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            name: RouteConstants.splash,
            path: '/splash',
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            name: RouteConstants.signIn,
            path: '/sign_in',
            builder: (context, state) => const SignInScreen(),
          ),
          GoRoute(
            name: RouteConstants.signUp,
            path: '/sign_up',
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            name: RouteConstants.checkLink,
            path: '/check_link',
            builder: (context, state) => const CheckLinkScreen(),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            name: RouteConstants.setUsername,
            path: '/set_username',
            builder: (context, state) => const SetUsernameScreen(),
          ),
          // Home screens ----------------------------------------------
          ShellRoute(
              navigatorKey: _shellNavigatorKey,
              builder: (context, state, child) {
                return BottomNavBar(
                  tabs: tabs,
                  child: child,
                );
              },
              routes: [
                // Home Screen
                GoRoute(
                  name: RouteConstants.home,
                  path: '/home',
                  pageBuilder: (context, state) => MaterialPage(
                      child: const HomeScreen(), key: state.pageKey),
                ),
                // Game Screen
                GoRoute(
                  name: RouteConstants.games,
                  path: '/games',
                  pageBuilder: (context, state) => MaterialPage(
                      child: const GamesScreen(), key: state.pageKey),
                ),
                // New Game Screen
                GoRoute(
                  name: RouteConstants.newGame,
                  path: '/new_game',
                  pageBuilder: (context, state) => MaterialPage(
                      child: const NewGameScreen(), key: state.pageKey),
                  routes: [
                    GoRoute(
                        name: RouteConstants.friendsGame,
                        path: 'friends_game',
                        pageBuilder: ((context, state) =>
                            const NoTransitionPage(
                                child: FriendsGameScreen()))),
                  ],
                ),
                // Profile Screen
                GoRoute(
                  name: RouteConstants.profile,
                  path: '/profile',
                  pageBuilder: (context, state) => MaterialPage(
                      child: const ProfileScreen(), key: state.pageKey),
                  routes: [
                    GoRoute(
                        name: RouteConstants.user,
                        path: 'user',
                        pageBuilder: ((context, state) {
                          User user = state.extra as User;
                          return NoTransitionPage(
                              child: UserScreen(user: user));
                        })),
                  ],
                ),
              ]),
          GoRoute(
              name: RouteConstants.joiningToGame,
              path: '/joining_to_game',
              pageBuilder: ((context, state) =>
                  const NoTransitionPage(child: JoiningToGameScreen()))),
          GoRoute(
              name: RouteConstants.drawingScreen,
              path: '/drawing_screen',
              pageBuilder: ((context, state) {
                Game game = state.extra as Game;
                return NoTransitionPage(
                    child: DrawingScreen(
                  game: game,
                ));
              })),
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
