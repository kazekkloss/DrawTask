import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';
import '../../config/router/route_constants.dart';
import '../../models/models.dart';

class GameScreen extends StatefulWidget {
  final String gameId;

  const GameScreen({Key? key, required this.gameId}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Vote> votes = [];

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        Game game =
            state.games.firstWhere((game) => game.id == widget.gameId);
        if (game.voted.length == game.pictures.length) {
          context.goNamed(RouteConstants.scoreScreen, extra: game);
        }
      },
      builder: (context, state) {
        Game game =
            state.games.firstWhere((game) => game.id == widget.gameId);
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 84.6.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    game.voted.contains(authBloc.state.user.id)
                        ? Text('Waiting for votes from other players.',
                            style: TextStyle(fontSize: 1.7.h))
                        : Text(
                            'Rate the drawings of the players. Please be aware that you can only use each rating once.',
                            style: TextStyle(fontSize: 1.7.h)),
                    SizedBox(
                      height: 5.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: game.pictures.length,
                      itemBuilder: (context, index) {
                        final Picture picture = game.pictures[index];
                        return picture.imageUrl != ''
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 2.3.h),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 84.6.w,
                                      child: Text(
                                        'Player ${index + 1}',
                                        style: TextStyle(fontSize: 1.9.h),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Container(
                                      height: 46.6.h,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 0.75),
                                            spreadRadius: -2,
                                            blurRadius: 8,
                                            color: Color.fromRGBO(
                                                108, 108, 108, 1),
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 84.6.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(0xffd9d9d9),
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(0, 0.75),
                                                  spreadRadius: -2,
                                                  blurRadius: 8,
                                                  color: Color.fromRGBO(
                                                      108, 108, 108, 1),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl: picture.imageUrl,
                                                placeholder: (context, url) => Center(
                                                    child: SizedBox(
                                                        height: 5.h,
                                                        width: 5.h,
                                                        child:
                                                            const CircularProgressIndicator(
                                                                color: Colors
                                                                    .black))),
                                                fit: BoxFit.contain,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.9.h,
                                          ),
                                          SizedBox(
                                            width: 84.6.w,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 2.5.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      picture
                                                          .userOwner.username!,
                                                      style: TextStyle(
                                                        fontSize: 2.1.h,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  Text(
                                                      '#${game.gameWords[0]}  #${game.gameWords[1]}  #${game.gameWords[2]}',
                                                      style: TextStyle(
                                                        fontSize: 2.1.h,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2.0.h),
                                    SizedBox(
                                      width: 67.9.w,
                                      child: game.voted
                                              .contains(authBloc.state.user.id)
                                          ? SizedBox(
                                              height: 5.3.h,
                                            )
                                          : game.pictures[index].userOwner.id ==
                                                  authBloc.state.user.id
                                              ? SizedBox(
                                                  height: 5.3.h,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    for (int i = 1; i <= 4; i++)
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (!votes.any((v) =>
                                                              v.id !=
                                                                  picture.id &&
                                                              v.point == i)) {
                                                            String pictureId =
                                                                picture.id!;

                                                            setState(() {
                                                              bool
                                                                  hasVoteWithSameIdAndPoint =
                                                                  votes.any((v) =>
                                                                      v.id ==
                                                                          pictureId &&
                                                                      v.point ==
                                                                          i);
                                                              if (hasVoteWithSameIdAndPoint) {
                                                                votes.removeWhere((v) =>
                                                                    v.id ==
                                                                        pictureId &&
                                                                    v.point ==
                                                                        i);
                                                              } else {
                                                                Vote vote =
                                                                    Vote(
                                                                  id: pictureId,
                                                                  point: i,
                                                                );
                                                                votes.removeWhere((v) =>
                                                                    v.id ==
                                                                        pictureId &&
                                                                    v.point !=
                                                                        i);
                                                                votes.add(vote);
                                                              }
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 5.3.h,
                                                          width: 5.3.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: votes.any((v) =>
                                                                    v.id ==
                                                                        picture
                                                                            .id &&
                                                                    v.point ==
                                                                        i)
                                                                ? Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1,
                                                                  )
                                                                : null,
                                                            color: votes.any((v) =>
                                                                    v.id !=
                                                                        picture
                                                                            .id &&
                                                                    v.point ==
                                                                        i)
                                                                ? const Color
                                                                    .fromARGB(
                                                                    101,
                                                                    217,
                                                                    217,
                                                                    217)
                                                                : const Color(
                                                                    0xffd9d9d9),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              i.toString(),
                                                              style: TextStyle(
                                                                fontSize: 1.8.h,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                    )
                                  ],
                                ),
                              )
                            : Container();
                      },
                    ),
                    InkWell(
                      splashColor: const Color.fromRGBO(217, 217, 217, 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: () => {
                        context.goNamed(RouteConstants.dashboard),
                      },
                      child: Ink(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(217, 217, 217, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 4.7.h,
                        width: 84.w,
                        child: const Center(
                            child: Text(
                          'Back',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                    SizedBox(height: 1.2.h),
                    game.voted.contains(authBloc.state.user.id)
                        ? SizedBox(
                            height: 4.7.h,
                          )
                        : InkWell(
                            splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              if (votes.length == game.pictures.length - 1) {
                                VotesSocket().addVotes(
                                    context: context,
                                    votes: votes,
                                    userIdVoice: authBloc.state.user.id,
                                    gameId: game.id);
                              }
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(75, 75, 75, 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 4.7.h,
                              width: 84.w,
                              child: const Center(
                                  child: Text(
                                'Vote',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                            ),
                          ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
