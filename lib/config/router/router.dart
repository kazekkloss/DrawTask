import 'package:drawtask/cubits/theme/theme_cubit.dart';
import 'package:drawtask/screens/main/user_screen.dart';
import 'package:drawtask/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../screens/main/widgets/bottom_nav_bar.dart';
import '../../sockets/sockets.dart';
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
    NavBarItem(
        initialLocation: '/home',
        icon: SvgPicture.asset(
          'assets/svg/home.svg',
          fit: BoxFit.fitHeight,
        ),
        label: ''),
    NavBarItem(
        initialLocation: '/dashboard',
        icon: SvgPicture.asset(
          'assets/svg/drawings.svg',
          fit: BoxFit.fitHeight,
        ),
        label: ''),
    NavBarItem(
        initialLocation: '/new_game',
        icon: SvgPicture.asset(
          'assets/svg/new_game.svg',
          fit: BoxFit.fitHeight,
        ),
        label: ''),
    NavBarItem(
        initialLocation: '/profile',
        icon: SvgPicture.asset(
          'assets/svg/profile.svg',
          fit: BoxFit.fitHeight,
        ),
        label: ''),
  ];

  GoRouter _router() => GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: _rootNavigatorKey,
        redirect: (context, state) {
          var authState = context.read<AuthBloc>().state;
          switch (authState.status) {
            case AuthStatus.unknown:
              return state.namedLocation(RouteConstants.splash);
            case AuthStatus.authenticated:
              if (previousStatus != authState.status) {
                previousStatus = authState.status;

                context
                    .read<ThemeCubit>()
                    .updateAvatarColor(authState.user.avatar!);

                GameSocket().gameOnListener(context);

                return state.namedLocation(RouteConstants.loading);
              } else {
                return null;
              }
            case AuthStatus.unauthenticated ||
                  AuthStatus.notVerified ||
                  AuthStatus.noUsername:
              if (previousStatus != authState.status) {
                previousStatus = authState.status;
                context.read<ThemeCubit>().updateAvatarColor('');
                return state.namedLocation(RouteConstants.auth);
              } else {
                return null;
              }
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
          // new auth screen ==============

          GoRoute(
              name: RouteConstants.auth,
              path: '/auth',
              pageBuilder: ((context, state) =>
                  const NoTransitionPage(child: AuthScreen()))),
          // ==============================
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              name: RouteConstants.loading,
              path: '/loading',
              pageBuilder: ((context, state) {
                return const NoTransitionPage(child: LoadingScreen());
              })),
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
                  pageBuilder: (context, state) => NoTransitionPage(
                      child: const HomeScreen(), key: state.pageKey),
                ),
                // Game Screen
                GoRoute(
                    name: RouteConstants.dashboard,
                    path: '/dashboard',
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: const DashboardScreen(), key: state.pageKey),
                    routes: [
                      GoRoute(
                        name: RouteConstants.scoreScreen,
                        path: 'score',
                        pageBuilder: ((context, state) {
                          Game game = state.extra as Game;
                          return NoTransitionPage(
                              child: ScoreScreen(
                            game: game,
                          ));
                        }),
                      ),
                    ]),
                // New Game Screen
                GoRoute(
                  name: RouteConstants.newGame,
                  path: '/new_game',
                  pageBuilder: (context, state) => NoTransitionPage(
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
                  pageBuilder: (context, state) => NoTransitionPage(
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
              path: '/drawing',
              pageBuilder: ((context, state) {
                Game game = state.extra as Game;
                return NoTransitionPage(
                    child: DrawingScreen(
                  game: game,
                ));
              })),
          GoRoute(
            name: RouteConstants.gameScreen,
            path: '/game',
            pageBuilder: ((context, state) {
              String gameId = state.extra as String;
              return NoTransitionPage(
                  child: GameScreen(
                gameId: gameId,
              ));
            }),
          ),
          GoRoute(
            name: RouteConstants.voteScreen,
            path: '/vote',
            pageBuilder: ((context, state) {
              String gameId = state.extra as String;
              return NoTransitionPage(
                  child: VoteScreen(
                gameId: gameId,
              ));
            }),
          ),
        ],
        errorPageBuilder: (context, state) {
          return const NoTransitionPage(
              child: Scaffold(
            body: Center(
              child: Text('Error route'),
            ),
          ));
        },
      );
  GoRouter get router => _router();
}
