import 'package:drawtask/config/config.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';
import 'widgets/avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Column(
                children: [
                  Avatar(user: state.user),
                  MainButton(
                      text: 'New Game',
                      onPressed: () {
                        context.goNamed(RouteConstants.newGame);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
