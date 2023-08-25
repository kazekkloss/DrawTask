import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';
import '../../../../cubits/cubits.dart';
import '../../../../models/models.dart';

class GameTab extends StatefulWidget {
  final User user;
  final Game game;
  const GameTab({super.key, required this.game, required this.user});

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  late Duration remainingTime;

  @override
  void initState() {
    final deadline = widget.game.createdAt.add(const Duration(hours: 12));
    remainingTime = deadline.difference(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final picture = widget.game.pictures.firstWhere(
      (picture) => picture.userOwner.id == widget.user.id,
    );

    GameStep gameStep = stepInGame(widget.game, picture);

    var timeStream =
        Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now())
            .map((currentTime) => currentTime.difference(widget.game.createdAt))
            .transform(DurationTransformer(context, widget.game.id));

    return Padding(
      padding: EdgeInsets.only(left: 5.4.w, right: 5.4.w, top: 1.18.h),
      child: GestureDetector(
        onTap: () {
          context.goNamed(RouteConstants.gameScreen, extra: widget.game.id);
        },
        child: Container(
          height: 13.5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 51, 51, 51),
          ),
          child: Padding(
            padding: EdgeInsets.all(1.18.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 39.4.w,
                        child: AutoSizeText(
                          '#${widget.game.gameWords[0]} #${widget.game.gameWords[1]} #${widget.game.gameWords[2]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          maxLines: 1,
                          minFontSize: 8,
                          maxFontSize: 18,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Your Move: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                              Text(
                                gameStep == GameStep.finish
                                    ? "Finish!"
                                    : gameStep == GameStep.waiting
                                        ? "Waiting!"
                                        : gameStep == GameStep.vote
                                            ? "Vote!"
                                            : "Draw!",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Time: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                              remainingTime.inHours < 1
                                  ? StreamBuilder<String>(
                                      stream: timeStream,
                                      builder: (context, snapshot) {
                                        return snapshot.data != null
                                            ? Text(
                                                snapshot.data.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : const SizedBox(
                                                height: 12,
                                                width: 12,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                ),
                                              );
                                      },
                                    )
                                  : Text(
                                      '${remainingTime.inHours.toString()}h',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: picture.imageUrl.isNotEmpty
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
                            : const Center(
                                child: Text('in progress',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
