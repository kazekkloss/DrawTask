import 'dart:async';

import 'package:drawtask/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class CheckLinkScreen extends StatefulWidget {
  const CheckLinkScreen({super.key});

  @override
  State<CheckLinkScreen> createState() => _CheckLinkScreenState();
}

class _CheckLinkScreenState extends State<CheckLinkScreen> {
  Timer? _timer;

  @override
  void initState() {
    _startChecking();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _stopChecking();
  }

  void _startChecking() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checking();
    });
  }

  void _stopChecking() {
    _timer?.cancel();
  }

  void _checking() {
    context.read<AuthBloc>().add(CheckAuthEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
            body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Column(
              children: [
                Text(
                  "DrawTask",
                  style: TextStyle(fontSize: 4.2.h, fontFamily: 'IrishGrover'),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Get Creative!",
                  style: TextStyle(fontSize: 2.h),
                ),
                SizedBox(
                  height: 17.7.h,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 10.6.h,
                  width: 84.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                        blurRadius: 10,
                        color: Color.fromRGBO(154, 154, 154, 1),
                      ),
                    ],
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: 'Please check your e-mail and click ',
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: 'link',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                            text: ' to activate your account.',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return InkWell(
                      splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        AuthRepository().resendMail(
                            context: context,
                            email: state.user.email,
                            userId: state.user.id);
                      },
                      child: Ink(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(75, 75, 75, 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 4.7.h,
                        width: 84.w,
                        child: const Center(
                            child: Text(
                          'Send link again',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    );
                  },
                ),
                SizedBox(height: 1.7.h),
                SizedBox(
                  width: 84.w,
                  child: const Text(
                    "Don't you have a link?",
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
