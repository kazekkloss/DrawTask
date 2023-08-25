import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  const ShadowContainer({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: -2,
                blurRadius: 6,
                color: Colors.black)
          ]),
      child: child,
    );
  }
}
