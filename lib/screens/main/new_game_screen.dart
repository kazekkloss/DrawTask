import 'package:drawtask/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

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
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 149, 149, 149),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    state.user.username.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 2.h),
                  InkWell(
                    splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      context.goNamed(RouteConstants.randomsGame);
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(75, 75, 75, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 18.7.h,
                      width: 84.w,
                      child: const Center(
                          child: Text(
                        'Random Player',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 1.1.h,
                  ),
                  InkWell(
                    splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      context.goNamed(RouteConstants.friendsGame);
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(75, 75, 75, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 18.7.h,
                      width: 84.w,
                      child: const Center(
                          child: Text(
                        "Friend's Game",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
