import 'package:drawtask/config/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class JoiningToGameScreen extends StatelessWidget {
  const JoiningToGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteConstants.newGame),
              child: const Text('Back'),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteConstants.drawingScreen),
              child: const Text('Drawing Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
