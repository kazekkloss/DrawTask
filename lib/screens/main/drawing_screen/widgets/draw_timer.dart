import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../cubits/cubits.dart';
import '../../../../models/models.dart';

class DrawTimer extends StatefulWidget {
  final Color primaryColor;
  final Game game;
  const DrawTimer({super.key, required this.game, required this.primaryColor});

  @override
  State<DrawTimer> createState() => _DrawTimerState();
}

class _DrawTimerState extends State<DrawTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double progress;
  late Duration timeLeft;

  @override
  void initState() {
    super.initState();
    timeLeft = widget.game.createdAt
        .add(const Duration(hours: 12))
        .difference(DateTime.now());
    setState(() {
      progress = getProgress();
    });
    _controller =
        AnimationController(vsync: this, duration: const Duration(hours: 12));

    _animation = Tween<double>(
      begin: progress,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          progress = getProgress();
        });
      });

    _controller.forward();
  }

  double getProgress() {
    return 1.0 - (timeLeft.inSeconds / const Duration(hours: 12).inSeconds);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return RotatedBox(
          quarterTurns: 90,
          child: SizedBox(
            height: 9.95.h,
            width: 9.95.h,
            child: CustomPaint(
              size: Size(9.95.h, 9.95.h),
              painter: SquarePainter(
                  progress: 0.0 - 1,
                  borderColor: const ui.Color.fromRGBO(217, 217, 217, 1)),
              child: CustomPaint(
                size: Size(9.95.h, 9.95.h),
                painter: SquarePainter(
                    progress: _animation.value,
                    borderColor: state.themeData.primaryColor),
                child: RotatedBox(
                    quarterTurns: 90,
                    child: Center(
                        child: Text(
                      timeLeft.inHours > 1
                          ? '${timeLeft.inHours}h'
                          : '${timeLeft.inMinutes} min',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w400),
                    ))),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SquarePainter extends CustomPainter {
  SquarePainter({required this.progress, required this.borderColor});
  double progress;
  Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    double x = min(size.height, size.width);
    double x2 = x / 2;
    Paint paintt = Paint()
      ..color = progress == 0 ? Colors.transparent : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    double cornerRadius = 28;

    Path path = Path()
      ..moveTo(x2, x)
      ..lineTo(cornerRadius, x)
      ..quadraticBezierTo(0, x, 0, x - cornerRadius)
      ..lineTo(0, cornerRadius)
      ..quadraticBezierTo(0, 0, cornerRadius, 0)
      ..lineTo(x - cornerRadius, 0)
      ..quadraticBezierTo(x, 0, x, cornerRadius)
      ..lineTo(x, x - cornerRadius)
      ..quadraticBezierTo(x, x, x - cornerRadius, x)
      ..lineTo(x2, x);

    ui.PathMetric pathMetric = path.computeMetrics().first;

    Path extractPath =
        pathMetric.extractPath(pathMetric.length * progress, pathMetric.length);
    canvas.drawPath(extractPath, paintt);
  }

  @override
  bool shouldRepaint(covariant SquarePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
