import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      )),
    );
  }
}
