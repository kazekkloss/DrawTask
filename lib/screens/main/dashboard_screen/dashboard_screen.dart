import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';

class DashboardScreen extends StatelessWidget {
  final bool appBar = true;
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Scaffold(
            body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.7.h),
                child: Container(
                  width: 85.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 0),
                            spreadRadius: -2,
                            blurRadius: 6,
                            color: Colors.black)
                      ]),
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: state.games.length,
                    itemBuilder: (context, index) {
                      final AuthBloc authBloc =
                          BlocProvider.of<AuthBloc>(context);
                      final game = state.games[index];
                      final hasMatchingPicture = game.pictures.any((picture) =>
                          picture.userOwner.id == authBloc.state.user.id &&
                          picture.imageUrl.isNotEmpty);

                      return Padding(
                        padding: EdgeInsets.only(
                            left: 5.12.w, right: 5.12.w, top: 1.2.h),
                        child: GestureDetector(
                          onTap: () {
                            hasMatchingPicture
                                ? context.pushNamed(RouteConstants.gameScreen,
                                    extra: game)
                                : context.goNamed(RouteConstants.drawingScreen,
                                    extra: game);
                          },
                          child: Container(
                            height: 9.36.h,
                            decoration: BoxDecoration(
                                color: hasMatchingPicture
                                    ? const Color.fromARGB(255, 154, 138, 0)
                                    : const Color.fromRGBO(75, 75, 75, 1.0),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('#${state.games[index].gameWords[0]}',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white)),
                                    Text('#${state.games[index].gameWords[1]}',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white)),
                                    Text('#${state.games[index].gameWords[2]}',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white)),
                                    Text(
                                        'drawings: ${game.pictures.where((picture) => picture.imageUrl.isNotEmpty).length}',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
