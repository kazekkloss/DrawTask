import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../blocs/blocs.dart';

class WidthTool extends StatelessWidget {
  final Color splashColor;
  final VoidCallback widthVoid;
  const WidthTool(
      {super.key, required this.splashColor, required this.widthVoid});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.9.h,
      width: 26.1.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: splashColor,
      ),
      child: Center(
        child: SizedBox(
          height: 17.7.h,
          width: 18.7.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildWidthOptions(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWidthOptions(BuildContext context) {
    final widthOptions = [40, 34, 24, 18, 10, 5];
    final totalHeight = 17.7.h;
    final equalHeight = totalHeight / widthOptions.length;
    return widthOptions.map((width) {
      return GestureDetector(
        onTap: () {
          context
              .read<DrawBloc>()
              .add(SkechWidthEvent(width: width.toDouble()));
          widthVoid();
        },
        child: SizedBox(
          height: equalHeight,
          child: Center(
            child: Container(
              width: double.maxFinite,
              height: _calculateHeight(width),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(51, 51, 51, 1),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  double _calculateHeight(int width) {
    return (width / 40) * 2.2.h;
  }
}
