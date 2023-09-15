import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/models.dart';

class GameScreen extends StatefulWidget {
  final Game game;
  const GameScreen({super.key, required this.game});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('#${widget.game.gameWords[0]}',
                  style: const TextStyle(fontSize: 15)),
              Text('#${widget.game.gameWords[1]}',
                  style: const TextStyle(fontSize: 15)),
              Text('#${widget.game.gameWords[2]}',
                  style: const TextStyle(fontSize: 15)),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: widget.game.pictures.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Container(
                    height: 80.w,
                    child: Image.network(
                      widget.game.pictures[index].imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
