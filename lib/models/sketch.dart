import 'package:flutter/material.dart';

import '/config/config.dart';

class Sketch {
  final List<Offset> points;
  final Color color;
  final double width;
  final DrawingMode mode;
  final bool filled;

  Sketch(
      {required this.points,
      required this.color,
      required this.width,
      required this.mode,
      required this.filled});

  Sketch copyWith({
    List<Offset>? points,
    Color? color,
    double? width,
    DrawingMode? mode,
    bool? filled,
  }) {
    return Sketch(
      points: points ?? this.points,
      color: color ?? this.color,
      width: width ?? this.width,
      mode: mode ?? this.mode,
      filled: filled ?? this.filled,
    );
  }
}