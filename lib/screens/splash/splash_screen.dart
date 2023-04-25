import 'dart:async';

import 'package:drawtask/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
