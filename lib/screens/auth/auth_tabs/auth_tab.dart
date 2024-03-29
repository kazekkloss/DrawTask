import 'package:drawtask/screens/auth/auth_tabs/create_tab.dart';
import 'package:drawtask/screens/auth/auth_tabs/sign_in.dart';
import 'package:drawtask/screens/auth/auth_tabs/sign_up.dart';
import 'package:drawtask/screens/auth/auth_tabs/verify_tab.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';

class AuthTab extends StatefulWidget {
  final VoidCallback voidSetDown;
  final AuthStatus authStatus;
  const AuthTab({
    required this.voidSetDown,
    required this.authStatus,
    super.key,
  });

  @override
  State<AuthTab> createState() => _AuthTabState();
}

class _AuthTabState extends State<AuthTab> {
  bool signIn = true;

  @override
  void initState() {
    if (widget.authStatus == AuthStatus.notVerified) {
      setState(() {
        signIn = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTab(
      height: 58.8.h,
      child: Stack(
        children: [
          AnimatedPositioned(
            right: widget.authStatus == AuthStatus.noUsername ? 100.w : 0,
            curve: Curves.linearToEaseOut,
            duration: const Duration(milliseconds: 600),
            child: SizedBox(
              height: 58.8.h,
              width: 100.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.4.h,
                  ),
                  Text(
                    "DrawTask",
                    style: TextStyle(fontSize: 4.6.h, fontFamily: 'Righteous'),
                  ),
                  Text(
                    "Get Creative!",
                    style: TextStyle(fontSize: 2.4.h, fontFamily: 'NotoSans'),
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      AnimatedPositioned(
                        right: signIn
                            ? 0
                            : widget.authStatus == AuthStatus.notVerified
                                ? 200.w
                                : 100.w,
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 600),
                        child: SignInTab(onPressed: () {
                          setState(() {
                            signIn = false;
                          });
                        }),
                      ),
                      AnimatedPositioned(
                        left: signIn
                            ? 100.w
                            : widget.authStatus == AuthStatus.notVerified
                                ? -100.w
                                : 0,
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 600),
                        child: SignUpTab(
                          navigate: () {
                            setState(() {
                              signIn = true;
                            });
                          },
                        ),
                      ),
                      AnimatedPositioned(
                          left: signIn
                              ? 200.w
                              : widget.authStatus == AuthStatus.notVerified
                                  ? 0
                                  : 100.w,
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 600),
                          child: VerifyTab(authStatus: widget.authStatus)),
                    ],
                  ))
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            left: widget.authStatus == AuthStatus.noUsername ? 0 : 100.w,
            curve: Curves.linearToEaseOut,
            duration: const Duration(milliseconds: 600),
            child: CreateTab(
              voidSetDown: () => widget.voidSetDown(),
            ),
          ),
        ],
      ),
    );
  }
}
