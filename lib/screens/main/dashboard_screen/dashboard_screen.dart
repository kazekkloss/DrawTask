import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final bool appBar = true;

  String formatDuration(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.5.h),
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
                        final hasMatchingPicture = game.pictures.any(
                            (picture) =>
                                picture.userOwner.id ==
                                    authBloc.state.user.id &&
                                picture.imageUrl.isNotEmpty);

                        var timeStream = Stream.periodic(
                                const Duration(seconds: 1),
                                (_) => DateTime.now())
                            .map((currentTime) => currentTime
                                .difference(state.games[index].createdAt))
                            .transform(DurationTransformer(
                                context, state.games[index].id));

                        return Padding(
                          padding: EdgeInsets.only(
                              left: 5.12.w, right: 5.12.w, top: 1.2.h),
                          child: GestureDetector(
                            onTap: () {
                              hasMatchingPicture
                                  ? context.pushNamed(RouteConstants.gameScreen,
                                      extra: game)
                                  : context.goNamed(
                                      RouteConstants.drawingScreen,
                                      extra: game);
                            },
                            child: Container(
                              height: 15.h,
                              decoration: BoxDecoration(
                                  color: hasMatchingPicture
                                      ? const Color.fromARGB(255, 154, 138, 0)
                                      : const Color.fromRGBO(75, 75, 75, 1.0),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          '#${state.games[index].gameWords[0]}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                      Text(
                                          '#${state.games[index].gameWords[1]}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                      Text(
                                          '#${state.games[index].gameWords[2]}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                      Text(
                                          'drawings: ${game.pictures.where((picture) => picture.imageUrl.isNotEmpty).length}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      StreamBuilder<String>(
                                        stream: timeStream,
                                        builder: (context, snapshot) {
                                          return snapshot.data != null
                                              ? Text(
                                                  'time: ${snapshot.data}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                )
                                              : const SizedBox(
                                                  height: 12,
                                                  width: 12,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                    color: Colors.white,
                                                  ));
                                        },
                                      ),
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
          ),
        );
      },
    );
  }
}
