import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';

class GamesScreen extends StatelessWidget {
  final bool appBar = true;
  const GamesScreen({super.key});

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
                  height: 50.h,
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
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 5.12.w, right: 5.12.w, top: 1.2.h),
                        child: Container(
                          height: 9.36.h,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(75, 75, 75, 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: Row(
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
                                    ],
                                  )),
                            ],
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
