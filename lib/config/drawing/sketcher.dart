import 'package:flutter/material.dart';

import '../../models/models.dart';

enum DrawingMode { pencil, line, square, circle }

class Sketcher extends CustomPainter {
  final List<Sketch> sketches;

  Sketcher({required this.sketches});

  @override
  void paint(Canvas canvas, Size size) {
    for (Sketch sketch in sketches) {
      final points = sketch.points;
      if (points.isEmpty) return;

      final path = Path();

      path.moveTo(points[0].dx, points[0].dy);
      if (points.length < 2) {
        // If the path only has one line, draw a dot.
        path.addOval(
          Rect.fromCircle(
            center: Offset(points[0].dx, points[0].dy),
            radius: 1,
          ),
        );
      }

      for (int i = 1; i < points.length - 1; ++i) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }

      Paint paint = Paint()
        ..color = sketch.color
        ..strokeCap = StrokeCap.round;
      paint.strokeWidth = sketch.width;

      if (!sketch.filled) {
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = sketch.width;
      }

      Offset firstPoint = sketch.points.first;
      Offset lastPoint = sketch.points.last;

      Rect rect = Rect.fromPoints(
        Offset(firstPoint.dx, firstPoint.dy),
        Offset(lastPoint.dx, lastPoint.dy),
      );

      if (sketch.mode == DrawingMode.pencil) {
        canvas.drawPath(path, paint);
      } else if (sketch.mode == DrawingMode.square) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          paint,
        );
      } else if (sketch.mode == DrawingMode.line) {
        canvas.drawLine(firstPoint, lastPoint, paint);
      } else if (sketch.mode == DrawingMode.circle) {
        canvas.drawOval(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant Sketcher oldDelegate) {
    return oldDelegate.sketches != sketches;
  }
}