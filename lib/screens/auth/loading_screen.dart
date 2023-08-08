import 'package:drawtask/config/router/route_constants.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    GameSocket().getAllGames(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state != const GameState.loading()) {
          context.goNamed(RouteConstants.home);
        }
      },
      child: Scaffold(
        body: Container(
            color: Colors.white,
            width: 100.w,
            height: 100.h,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/svg/static_background.svg',
                  fit: BoxFit.cover,
                ),
                Container(
                  color: const Color.fromARGB(192, 255, 255, 255),
                  width: 100.w,
                  height: 100.h,
                ),
                Center(
                  child: Container(
                    height: 76.w,
                    width: 84.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(192, 51, 51, 51)),
                    child: Column(
                      children: [
                        SizedBox(height: 4.2.h),
                        Text(
                          "DrawTask",
                          style: TextStyle(
                              fontSize: 3.8.h,
                              fontFamily: 'Righteous',
                              color: Colors.white),
                        ),
                        SizedBox(height: 2.2.h),
                        Text(
                          "Get Creative!",
                          style: TextStyle(
                              fontSize: 2.4.h,
                              fontFamily: 'NotoSans',
                              color: Colors.white),
                        ),
                        Expanded(
                            child: Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
