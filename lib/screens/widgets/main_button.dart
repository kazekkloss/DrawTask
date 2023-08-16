import 'package:drawtask/cubits/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MainButton extends StatefulWidget {
  final Color? textColor;
  final Color? primaryColor;
  final Color? splashColor;
  final VoidCallback onPressed;
  final String text;
  const MainButton({
    this.textColor,
    this.primaryColor,
    this.splashColor,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: widget.onPressed,
          onTapDown: (_) {
            setState(() {
              isPressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              isPressed = false;
            });
          },
          child: AnimatedContainer(
            height: 4.6.h,
            width: SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
                color: isPressed
                    ? widget.splashColor ?? state.themeData.splashColor
                    : widget.primaryColor ?? state.themeData.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Text(
              widget.text,
              style: TextStyle(
                  color: widget.textColor ?? state.textButtonColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            )),
          ),
        );
      },
    );
  }
}
