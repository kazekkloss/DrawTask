import 'package:drawtask/screens/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomPanel extends StatelessWidget {
  final bool? shape;
  final VoidCallback voidBack;
  final Widget? finishButton;
  const BottomPanel(
      {super.key, bool? shape, required this.voidBack, this.finishButton})
      : shape = shape ?? true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        boxShadow: shape!
            ? [
                const BoxShadow(
                  offset: Offset(0, 0),
                  spreadRadius: -2,
                  blurRadius: 8,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ]
            : [],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 2.3.h),
          MainButton(
            primaryColor: const Color.fromARGB(255, 51, 51, 51),
            splashColor: const Color.fromARGB(255, 81, 81, 81),
            text: 'Back',
            textColor: const Color.fromARGB(255, 255, 255, 255),
            onPressed: voidBack,
          ),
          SizedBox(height: 1.2.h),
          finishButton != null
              ? finishButton!
              : SizedBox(
                  height: 4.6.h,
                  width: 4.6.h,
                ),
          SizedBox(height: 2.3.h),
        ],
      ),
    );
  }
}
