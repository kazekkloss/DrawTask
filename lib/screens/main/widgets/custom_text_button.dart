import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../cubits/cubits.dart';

class CustomTextButton extends StatelessWidget {
  final double? fontSize;
  final bool onTapped;
  final String text;
  final VoidCallback onTap;
  const CustomTextButton({
    super.key,
    this.fontSize,
    required this.text,
    required this.onTap,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: fontSize ?? 18,
                    fontWeight: onTapped ? FontWeight.w700 : FontWeight.w300,
                    color: const Color.fromRGBO(0, 0, 0, 1)),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: state.themeData.primaryColor,
                height: 0.5.h,
                width: onTapped ? 26 : 0,
              )
            ],
          ),
        );
      },
    );
  }
}
