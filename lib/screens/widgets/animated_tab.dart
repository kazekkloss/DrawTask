import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AnimatedTab extends StatelessWidget {
  final double height;
  final Widget child;
  const AnimatedTab({super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.8.h,
      width: 100.w,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: -2,
              blurRadius: 8,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ]),
      child: child,
    );
  }
}
