import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewGameButton extends StatelessWidget {
  final VoidCallback onTap;
  final String textButton;
  const NewGameButton({
    required this.textButton,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(51, 51, 51, 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 84.6.w,
        height: 18.7.h,
        child: Center(
          child: Text(textButton,
              style: const TextStyle(fontSize: 26, color: Colors.white)),
        ),
      ),
    );
  }
}
