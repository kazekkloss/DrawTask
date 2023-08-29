import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';
import '../../../cubits/cubits.dart';
import '../../../models/models.dart';

class ImageButton extends StatelessWidget {
  final GameStep? gameStep;
  final Game? game;
  final VoidCallback? onTap;
  final String imageUrl;
  const ImageButton({
    super.key,
    this.game,
    required this.imageUrl,
    this.onTap,
    GameStep? gameStep,
  }) : gameStep = gameStep ?? GameStep.waiting;

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
              ? GestureDetector(
                  onTap: onTap,
                  child: BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) => Center(
                            child: SizedBox(
                                height: 3.h,
                                width: 3.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: state.themeData.primaryColor,
                                ))),
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    },
                  ),
                )
              : gameStep == GameStep.draw
                  ? GestureDetector(
                      onTap: () {
                        context.goNamed(RouteConstants.drawingScreen,
                            extra: game);
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/go_draw.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : gameStep == GameStep.vote
                      ? GestureDetector(
                          onTap: () {
                            context.goNamed(RouteConstants.voteScreen,
                                extra: game!.id);
                          },
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svg/vote.svg',
                              height: 3.7.h,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            context.goNamed(RouteConstants.voteScreen,
                                extra: game!.id);
                          },
                          child: Center(
                              child: Icon(
                            Icons.check_box_outlined,
                            size: 4.h,
                          )),
                        ),
        ),
      ),
    );
  }
}
