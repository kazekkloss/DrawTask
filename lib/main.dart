import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'blocs/blocs.dart';
import 'config/config.dart';
import 'repositories/repositories.dart';
import 'screens/screens.dart';

void main() {
  runApp(const DrawTask());
}

class DrawTask extends StatefulWidget {
  const DrawTask({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawTask> createState() => _DrawTaskState();
}

class _DrawTaskState extends State<DrawTask> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            initialRoute: SplashScreen.routeName,
            builder: (context, child) {
              return BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthStatus.authenticated:
                      _navigatorKey.currentState
                          ?.pushReplacementNamed(HomeScreen.routeName);
                      break;
                    case AuthStatus.notVerified:
                      _navigatorKey.currentState
                          ?.pushReplacementNamed(CheckLinkScreen.routeName);
                      break;
                    case AuthStatus.noUsername:
                      _navigatorKey.currentState
                          ?.pushReplacementNamed(SetUsernameScreen.routeName);
                      break;
                    case AuthStatus.unauthenticated:
                      _navigatorKey.currentState
                          ?.pushReplacementNamed(SignInScreen.routeName);
                      break;
                    default:
                      break;
                  }
                },
                child: child,
              );
            },
            onGenerateRoute: (settings) => generateRoute(settings),
          ),
        ),
      );
    });
  }
}
