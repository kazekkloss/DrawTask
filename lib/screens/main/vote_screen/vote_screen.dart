import 'package:drawtask/screens/main/vote_screen/widgets/vote_numbers.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';
import '../../../models/models.dart';
import '../../../sockets/voted_socket.dart';
import '../widgets/widgets.dart';

class VoteScreen extends StatefulWidget {
  final String gameId;
  const VoteScreen({super.key, required this.gameId});

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  List<Vote> votes = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        Game game = state.games.firstWhere((game) => game.id == widget.gameId);
        if (game.voted.length == game.pictures.length) {
          context.goNamed(RouteConstants.scoreScreen, extra: game);
        }
      },
      builder: (context, state) {
        final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
        Game game = state.games.firstWhere((game) => game.id == widget.gameId);
        List<Picture> pictures = sortedPictures(game, authBloc.state.user.id);
        pictures = pictures.reversed.toList();
        return Scaffold(
          appBar: TopAppBar(gameWords: game.gameWords),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: SizedBox(
                    width: 90.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.7.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Rate the drawings of the players. Please be aware that you can only use each rating once.',
                              style: TextStyle(fontSize: 1.7.h)),
                          SizedBox(
                            height: 5.h,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: pictures.length,
                            itemBuilder: (context, index) {
                              String pictureId = pictures[index].id!;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2.3.h),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 84.6.w,
                                      child: Text(
                                        pictures[index].userOwner.id ==
                                                authBloc.state.user.id
                                            ? 'Your image'
                                            : 'Player ${index + 1}',
                                        style: TextStyle(fontSize: 1.9.h),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    ShadowContainer(
                                        child: ImageWidget(
                                      imageUrl: pictures[index].imageUrl,
                                    )),
                                    SizedBox(height: 2.0.h),
                                    game.voted.contains(authBloc.state.user.id)
                                        ? SizedBox(
                                            height: 5.3.h,
                                          )
                                        : pictures[index].userOwner.id ==
                                                authBloc.state.user.id
                                            ? SizedBox(
                                                height: 5.3.h,
                                              )
                                            : VoteNumbers(
                                                votes: votes,
                                                pictureId: pictureId,
                                                onTap: (value) {
                                                  if (!votes.any((v) =>
                                                      v.id != pictureId &&
                                                      v.point == value)) {
                                                    setState(() {
                                                      bool
                                                          hasVoteWithSameIdAndPoint =
                                                          votes.any((v) =>
                                                              v.id ==
                                                                  pictureId &&
                                                              v.point == value);
                                                      if (hasVoteWithSameIdAndPoint) {
                                                        votes.removeWhere((v) =>
                                                            v.id == pictureId &&
                                                            v.point == value);
                                                      } else {
                                                        Vote vote = Vote(
                                                          id: pictureId,
                                                          point: value,
                                                        );
                                                        votes.removeWhere((v) =>
                                                            v.id == pictureId &&
                                                            v.point != value);
                                                        votes.add(vote);
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 100.w,
                  height: 12.74.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainButton(
                          primaryColor: const Color.fromARGB(255, 51, 51, 51),
                          splashColor: const Color.fromARGB(255, 81, 81, 81),
                          textColor: const Color.fromARGB(255, 255, 255, 255),
                          text: 'Back',
                          onPressed: () {
                            context.goNamed(RouteConstants.gameScreen,
                                extra: game.id);
                          }),
                      game.voted.contains(authBloc.state.user.id)
                          ? SizedBox(
                              height: 4.6.h,
                            )
                          : MainButton(
                              text: 'Finish',
                              onPressed: () {
                                if (votes.length == game.pictures.length - 1) {
                                  VotesSocket().addVotes(
                                      context: context,
                                      votes: votes,
                                      userIdVoice: authBloc.state.user.id,
                                      gameId: game.id);
                                }
                              }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
