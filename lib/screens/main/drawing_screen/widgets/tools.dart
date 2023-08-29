import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../drawing_screen.dart';

class Tools extends StatelessWidget {
  final Color primaryColor;
  final Color splashColor;
  final VoidCallback colorVoid;
  final VoidCallback widthVoid;
  final VoidCallback backgroundVoid;
  final VoidCallback shapeVoid;
  final ActiveBarTool activeBarTool;
  const Tools({
    required this.primaryColor,
    required this.splashColor,
    required this.colorVoid,
    required this.backgroundVoid,
    required this.widthVoid,
    required this.shapeVoid,
    required this.activeBarTool,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.3.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: backgroundVoid,
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: activeBarTool == ActiveBarTool.backgroundColor
                        ? splashColor
                        : primaryColor),
                child: SvgPicture.asset(
                  'assets/svg/tools/paint.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widthVoid();
              },
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: activeBarTool == ActiveBarTool.width
                        ? splashColor
                        : primaryColor),
                child: SvgPicture.asset(
                  'assets/svg/tools/pen.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            GestureDetector(
              onTap: colorVoid,
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: activeBarTool == ActiveBarTool.colors
                        ? splashColor
                        : primaryColor),
                child: SvgPicture.asset(
                  'assets/svg/tools/palette.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            GestureDetector(
              onTap: shapeVoid,
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: activeBarTool == ActiveBarTool.shapes
                        ? splashColor
                        : primaryColor),
                child: SvgPicture.asset(
                  'assets/svg/tools/shapes.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
