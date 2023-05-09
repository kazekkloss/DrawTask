import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'blocs/blocs.dart';
import 'config/go_router.dart';
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
          ],
          child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AuthBloc(
                    authRepository: context.read<AuthRepository>(),
                  ),
                ),
              ],
              child: Builder(builder: (context) {
                return MaterialApp.router(
                  //routerConfig: AppRouter(context: context).router,
                  routeInformationParser:
                      AppRouter(context: context).router.routeInformationParser,
                  routerDelegate:
                      AppRouter(context: context).router.routerDelegate,
                  routeInformationProvider: AppRouter(context: context)
                      .router
                      .routeInformationProvider,
                  debugShowCheckedModeBanner: false,
                );
              })));
    });
  }
}
