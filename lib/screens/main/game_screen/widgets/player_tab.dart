import 'package:drawtask/screens/main/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';
import '../../../../cubits/cubits.dart';
import '../../../../models/models.dart';

class PlayerTab extends StatelessWidget {
  final int numInList;
  final GameStep gameStep;
  final bool isCurrenUserOwner;
  final Picture picture;
  final Game game;
  const PlayerTab(
      {super.key,
      required this.numInList,
      required this.picture,
      required this.game,
      required this.isCurrenUserOwner,
      required this.gameStep});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SmallTab(
          color: isCurrenUserOwner
              ? state.themeData.primaryColor
              : const Color.fromARGB(255, 75, 75, 75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.7.h, left: 4.1.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCurrenUserOwner
                          ? picture.userOwner.username.toString()
                          : 'Player $numInList',
                      style: TextStyle(
                        color: isCurrenUserOwner
                            ? const Color.fromARGB(255, 75, 75, 75)
                            : const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 21,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          isCurrenUserOwner ? 'Your Move: ' : 'Move: ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: isCurrenUserOwner
                                  ? const Color.fromARGB(255, 75, 75, 75)
                                  : const Color.fromARGB(255, 255, 255, 255)),
                        ),
                        Text(
                          gameStep == GameStep.finish
                              ? "Finish!"
                              : gameStep == GameStep.waiting
                                  ? "Waiting!"
                                  : gameStep == GameStep.vote
                                      ? "Vote!"
                                      : "Draw!",
                          style: TextStyle(
                            fontSize: 14,
                            color: isCurrenUserOwner
                                ? const Color.fromARGB(255, 75, 75, 75)
                                : const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              if (isCurrenUserOwner)
                ImageButton(
                    imageUrl: picture.imageUrl, game: game, gameStep: gameStep),
            ],
          ),
        );
      },
    );
  }
}
