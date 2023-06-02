import 'package:drawtask/config/router/route_constants.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 25.h),
              child: Column(
                children: [
                  Text(
                    "DrawTask",
                    style:
                        TextStyle(fontSize: 4.2.h, fontFamily: 'IrishGrover'),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Get Creative!",
                    style: TextStyle(fontSize: 2.h),
                  ),
                  SizedBox(height: 10.h),
                  const CircularProgressIndicator(
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
