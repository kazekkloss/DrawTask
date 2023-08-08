import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

enum ActiveTool { color, width, shape, none }

class Tools extends StatefulWidget {
  final Color primaryColor;
  final Color splashColor;
  final VoidCallback colorVoid;
  final VoidCallback widthVoid;
  final VoidCallback backgroundVoid;
  final VoidCallback shapeVoid;
  const Tools({
    required this.primaryColor,
    required this.splashColor,
    required this.colorVoid,
    required this.backgroundVoid,
    required this.widthVoid,
    required this.shapeVoid,
    super.key,
  });

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  bool paint = false;
  bool pen = false;
  bool palette = false;
  bool shapes = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.3.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: widget.primaryColor, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.backgroundVoid();
                setState(() {
                  paint = !paint;
                  pen = false;
                  palette = false;
                  shapes = false;
                });
              },
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: paint ? widget.splashColor : widget.primaryColor),
                child: SvgPicture.asset(
                  'assets/svg/tools/paint.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.widthVoid();
                setState(() {
                  paint = false;
                  pen = !pen;
                  palette = false;
                  shapes = false;
                });
              },
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: pen ? widget.splashColor : widget.primaryColor),
                child: SvgPicture.asset(
                  'assets/svg/tools/pen.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.colorVoid();
                setState(() {
                  paint = false;
                  pen = false;
                  palette = !palette;
                  shapes = false;
                });
              },
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: palette ? widget.splashColor : widget.primaryColor),
                child: SvgPicture.asset(
                  'assets/svg/tools/palette.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.shapeVoid();
                setState(() {
                  paint = false;
                  pen = false;
                  palette = false;
                  shapes = !shapes;
                });
              },
              child: Container(
                height: 8.3.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: shapes ? widget.splashColor : widget.primaryColor),
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
