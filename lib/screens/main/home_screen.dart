import 'package:drawtask/config/config.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

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
                  Container(
                    height: 11.h,
                    width: 11.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: state.user.avatar == null
                          ? null
                          : Lottie.asset(state.user.avatar!, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    state.user.username.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 2.h),
                  MainButton(
                      text: 'New Game',
                      onPressed: () {
                        context.goNamed(RouteConstants.newGame);
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
