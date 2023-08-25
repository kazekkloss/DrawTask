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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
        final Game game =
            state.games.firstWhere((game) => game.id == widget.gameId);
        List<Picture> pictures = sortedPictures(game, authBloc.state.user.id);
        return Scaffold(
            appBar: TopAppBar(gameWords: game.gameWords),
            body: Center(
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
                              GameStep gameStep =
                                  stepInGame(game, pictures[index]);
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 5.4.w, right: 5.4.w, top: 1.18.h),
                                  child: PlayerTab(
                                    game: game,
                                    gameStep: gameStep,
                                    picture: pictures[index],
                                    currenUserOwner: authBloc.state.user.id ==
                                        pictures[index].userOwner.id,
                                  ));
                            }),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 7.1.h),
                            child: MainButton(
                              primaryColor:
                                  const Color.fromARGB(255, 51, 51, 51),
                              splashColor:
                                  const Color.fromARGB(255, 81, 81, 81),
                              textColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              text: 'Back',
                              onPressed: () {
                                context.goNamed(RouteConstants.dashboard);
                                context.read<DrawBloc>().add(ClearEvent());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
