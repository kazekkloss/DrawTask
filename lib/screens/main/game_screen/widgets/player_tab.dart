import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';
import '../../../../cubits/cubits.dart';
import '../../../../models/models.dart';

class PlayerTab extends StatelessWidget {
  final GameStep gameStep;
  final bool currenUserOwner;
  final Picture picture;
  final Game game;
  const PlayerTab(
      {super.key,
      required this.picture,
      required this.game,
      required this.currenUserOwner,
      required this.gameStep});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: currenUserOwner
                  ? state.themeData.primaryColor
                  : const Color.fromARGB(255, 75, 75, 75)),
          height: 9.3.h,
          width: 74.w,
          child: Padding(
            padding: EdgeInsets.only(right: 2.5.w, top: 1.18.h, bottom: 1.18.h),
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
                        picture.userOwner.username.toString(),
                        style: TextStyle(
                          color: currenUserOwner
                              ? const Color.fromARGB(255, 75, 75, 75)
                              : const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 21,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            currenUserOwner ? 'Your Move: ' : 'Move: ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: currenUserOwner
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
                              color: currenUserOwner
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
                if (currenUserOwner)
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 5),
                                spreadRadius: -3,
                                blurRadius: 8,
                                color: Color(0x85000000),
                              ),
                            ],
                            color: Colors.white),
                        child: gameStep == GameStep.waiting
                            ? BlocBuilder<ThemeCubit, ThemeState>(
                                builder: (context, state) {
                                  return CachedNetworkImage(
                                    imageUrl: picture.imageUrl,
                                    placeholder: (context, url) => Center(
                                        child: SizedBox(
                                            height: 3.h,
                                            width: 3.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color:
                                                  state.themeData.primaryColor,
                                            ))),
                                    fit: BoxFit.contain,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  );
                                },
                              )
                            : gameStep == GameStep.draw
                                ? GestureDetector(
                                    onTap: () {
                                      context.goNamed(
                                          RouteConstants.drawingScreen,
                                          extra: game);
                                    },
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/svg/go_draw.svg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      context.goNamed(RouteConstants.voteScreen,
                                          extra: game.id);
                                    },
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/svg/vote.svg',
                                        height: 3.7.h,
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
