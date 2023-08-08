import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../blocs/blocs.dart';
import '../../../../config/config.dart';

class ShapesTool extends StatelessWidget {
  final Color splashColor;
  final VoidCallback shapesVoid;
  const ShapesTool({
    super.key,
    required this.splashColor,
    required this.shapesVoid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.9.h,
      width: 26.1.w,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: splashColor),
      child: Center(
        child: SizedBox(
          height: 17.7.h,
          width: 18.7.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<DrawBloc>()
                          .add(ChangeModeEvent(mode: DrawingMode.square));
                      context.read<DrawBloc>().add(SetFillEvent(filled: true));
                      shapesVoid();
                    },
                    child: Container(
                        height: 3.9.h,
                        width: 3.9.h,
                        color: const Color.fromRGBO(51, 51, 51, 1)),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<DrawBloc>()
                          .add(ChangeModeEvent(mode: DrawingMode.square));
                      context.read<DrawBloc>().add(SetFillEvent(filled: false));
                      shapesVoid();
                    },
                    child: Container(
                        height: 3.9.h,
                        width: 3.9.h,
                        decoration: BoxDecoration(border: Border.all())),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<DrawBloc>()
                          .add(ChangeModeEvent(mode: DrawingMode.circle));
                      context.read<DrawBloc>().add(SetFillEvent(filled: true));
                      shapesVoid();
                    },
                    child: Container(
                      height: 3.9.h,
                      width: 3.9.h,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(51, 51, 51, 1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all()),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<DrawBloc>()
                          .add(ChangeModeEvent(mode: DrawingMode.circle));
                      context.read<DrawBloc>().add(SetFillEvent(filled: false));
                      shapesVoid();
                    },
                    child: Container(
                        height: 3.9.h,
                        width: 3.9.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all())),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<DrawBloc>()
                      .add(ChangeModeEvent(mode: DrawingMode.line));
                  shapesVoid();
                },
                child: SizedBox(
                  height: 3.h,
                  child: Center(
                    child: Container(
                      width: double.maxFinite,
                      height: 3,
                      color: const Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: 3.9.h,
                      child: SvgPicture.asset(
                        'assets/svg/eraser_tool.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<DrawBloc>()
                          .add(ChangeModeEvent(mode: DrawingMode.pencil));
                      context.read<DrawBloc>().add(SetFillEvent(filled: false));
                      shapesVoid();
                    },
                    child: SizedBox(
                      height: 3.9.h,
                      child: SvgPicture.asset(
                        'assets/svg/pencil_tool.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
