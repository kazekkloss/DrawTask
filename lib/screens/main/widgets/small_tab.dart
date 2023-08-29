import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SmallTab extends StatelessWidget {
  final Color color;
  final Widget child;
  const SmallTab({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.3.h,
      width: 74.w,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Padding(
          padding: EdgeInsets.only(right: 2.5.w, top: 1.18.h, bottom: 1.18.h),
          child: child),
    );
  }
}
