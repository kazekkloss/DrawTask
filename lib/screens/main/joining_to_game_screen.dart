import 'package:drawtask/config/config.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';


class JoiningToGameScreen extends StatefulWidget {
  const JoiningToGameScreen({super.key});

  @override
  State<JoiningToGameScreen> createState() => _JoiningToGameScreenState();
}

class _JoiningToGameScreenState extends State<JoiningToGameScreen> {
  @override
  void initState() {
    GameSocket().joinToGame(context: context);
    super.initState();
  }

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
          ],
        ),
      ),
    );
  }
}
