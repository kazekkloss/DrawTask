import 'package:drawtask/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class CheckLinkScreen extends StatelessWidget {
  static const routeName = '/check_link_screen';
  const CheckLinkScreen({super.key});

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
                        TextSpan(text: 'Please check your e-mail and click '),
                        TextSpan(
                          text: 'link',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' to activate your account.'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return GestureDetector(
                      child: Container(
                        height: 4.7.h,
                        width: 84.w,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Center(
                            child: Text(
                          'Send link again',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        AuthRepository().resendMail(
                            context: context,
                            email: state.user.email,
                            userId: state.user.id);
                      },
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
                Expanded(
                    child: Center(
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(CheckAuthEvent(context: context));
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ))
              ],
            ),
          ),
        ));
      },
    );
  }
}
