import 'package:drawtask/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'blocs/blocs.dart';
import 'cubits/cubits.dart';
import 'repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  await FlutterStatusbarcolor.setStatusBarColor(
      const Color.fromRGBO(255, 255, 255, 1));
  await FlutterStatusbarcolor.setNavigationBarColor(
      const Color.fromRGBO(255, 255, 255, 1));
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
          RepositoryProvider<FriendsRepository>(
            create: (context) => FriendsRepository(),
          ),
          RepositoryProvider<DrawingsRepository>(
            create: (context) => DrawingsRepository(),
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
              create: (context) => FriendsBloc(
                friendsRepository: context.read<FriendsRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => DrawingsBloc(
                drawingsRepository: context.read<DrawingsRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => GameBloc(),
            ),
            BlocProvider(
              create: (context) => DrawBloc(),
            ),
            BlocProvider(
              create: (context) => ThemeCubit(),
            ),
          ],
          child: Builder(builder: (context) {
            return MaterialApp.router(
              routerConfig: AppRouter(context: context).router,
              debugShowCheckedModeBanner: false,
              theme: theme(),
            );
          }),
        ),
      );
    });
  }
}
