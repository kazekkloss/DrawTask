import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../blocs/draw/draw_bloc.dart';

class TopButtons extends StatelessWidget {
  final Color primaryColor;
  const TopButtons({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.read<DrawBloc>().add(UndoEvent()),
          child: Container(
            height: 4.4.h,
            width: 4.4.h,
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.replay,
              color: primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        GestureDetector(
          onTap: () => context.read<DrawBloc>().add(ClearEvent()),
          child: Container(
            height: 4.4.h,
            width: 4.4.h,
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.layers_clear,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
