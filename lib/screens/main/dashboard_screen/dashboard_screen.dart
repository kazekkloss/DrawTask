import 'package:drawtask/screens/main/dashboard_screen/widgets/game_tab.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String formatDuration(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 85.w,
                child: Column(
                  children: [
                    SizedBox(height: 3.07.h),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Random Games",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.2.h),
                    ShadowContainer(
                      height: state.games.isEmpty
                          ? 20.h
                          : 14.68.h * state.games.length.toDouble() + 3.48.h,
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.18.h),
                        child: state.games.isEmpty
                            ? const Center(
                                child: Text(
                                  "You don't have any games yet",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.games.length,
                                itemBuilder: (context, index) {
                                  final AuthBloc authBloc =
                                      BlocProvider.of<AuthBloc>(context);
                                  return GameTab(
                                    game: state.games[index],
                                    user: authBloc.state.user,
                                  );
                                }),
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
