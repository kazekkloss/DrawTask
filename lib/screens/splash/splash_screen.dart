import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSvg = false;
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      setState(() {
        isSvg = true;
      });
      context.read<AuthBloc>().add(CheckAuthEvent(context: context));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: Stack(
          children: [
            if (isSvg)
              SvgPicture.asset(
                'assets/svg/static_background.svg',
                fit: BoxFit.cover,
              ),
            const RiveAnimation.asset(
              'assets/animations/background.riv',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
