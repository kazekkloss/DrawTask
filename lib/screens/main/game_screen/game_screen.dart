import 'package:drawtask/screens/main/game_screen/widgets/player_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';
import '../../../models/models.dart';
import '../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class GameScreen extends StatefulWidget {
  final String gameId;
  const GameScreen({super.key, required this.gameId});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool zoom = false;

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
        final Game game =
            state.games.firstWhere((game) => game.id == widget.gameId);
        List<Picture> pictures =
            GlobalVariables().sortedPictures(game, authBloc.state.user.id);
        return Scaffold(
            appBar: TopAppBar(
              gameWords: game.gameWords,
              isLeading: true,
            ),
            body: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 85.w,
                    child: Column(
                      children: [
                        SizedBox(height: 3.0.h),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Players",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.2.h),
                        ShadowContainer(
                          height: pictures.isEmpty
                              ? 14.2.h
                              : 10.48.h * pictures.length.toDouble() + 3.48.h,
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.18.h),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: pictures.length,
                                itemBuilder: (context, index) {
                                  GameStep gameStep = GlobalVariables()
                                      .stepInGame(game, pictures[index],
                                          authBloc.state.user.id);
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.4.w,
                                          right: 5.4.w,
                                          top: 1.18.h),
                                      child: PlayerTab(
                                          numInList: index,
                                          game: game,
                                          gameStep: gameStep,
                                          picture: pictures[index],
                                          isCurrenUserOwner: pictures[index] ==
                                              pictures.first));
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // if (pictures.first.imageUrl.isNotEmpty &&
                //     pictures.any((picture) => picture.imageUrl.isEmpty))
                //   ZoomDrawing(
                //     onTap: () {
                //       setState(() {
                //         zoom = !zoom;
                //       });
                //     },
                //     imageUrl: pictures.first.imageUrl,
                //     zoom: zoom,
                //   )
              ],
            ));
      },
    );
  }
}
