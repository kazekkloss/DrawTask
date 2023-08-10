import 'package:drawtask/screens/auth/auth_tabs/auth_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showAuthTab = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        showAuthTab = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    width: 100.w,
                    height: 100.h,
                    child: SvgPicture.asset(
                      'assets/svg/static_background.svg',
                      fit: BoxFit.cover,
                    )),
              ),
              AnimatedPositioned(
                bottom: showAuthTab ? 0 : -62.h,
                curve: Curves.linearToEaseOut,
                duration: const Duration(milliseconds: 1000),
                child: AuthTab(
                  voidSetDown: () => setState(() {
                    showAuthTab = false;
                  }),
                  authStatus: state.status,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
