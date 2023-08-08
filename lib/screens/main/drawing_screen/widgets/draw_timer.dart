import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';
import '../../../../models/models.dart';

import 'dart:async';

class DrawTimer extends StatefulWidget {
  final Color primaryColor;
  final Game game;
  const DrawTimer({super.key, required this.game, required this.primaryColor});

  @override
  State<DrawTimer> createState() => _DrawTimerState();
}

class _DrawTimerState extends State<DrawTimer> {
  @override
  Widget build(BuildContext context) {
    final timeStream =
        Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now())
            .map((currentTime) => currentTime.difference(widget.game.createdAt))
            .transform(DurationTransformer(context, widget.game.id));
    return StreamBuilder<Object>(
        stream: timeStream,
        builder: (context, snapshot) {
          return Container(
            height: 10.7.h,
            width: 10.7.h,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                border: Border.all(color: widget.primaryColor, width: 5),
                borderRadius: BorderRadius.circular(25)),
            child: Center(
                child: Text(
              '${snapshot.data ?? "loading"}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
          );
        });
  }
}
