import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'blocs/blocs.dart';
import 'config/router/router.dart';
import 'repositories/repositories.dart';

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
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(),
          ),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider<GameSocket>(
            create: (context) => GameSocket(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => UsersBloc(
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => GameBloc(
                gameSocket: context.read<GameSocket>(),
              ),
            ),
            BlocProvider(
              create: (context) => DrawBloc(),
            ),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp.router(
                routerConfig: AppRouter(context: context).router,
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        ),
      );
    });
  }
}
