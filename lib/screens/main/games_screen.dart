import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  final bool appBar = true;
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Games Screen')),
    );
  }
}
