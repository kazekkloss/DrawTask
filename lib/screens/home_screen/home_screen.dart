import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawtask/config/config.dart';
import 'package:drawtask/screens/home_screen/widgets/drawing_tab.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';
import '../main/widgets/avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: SizedBox(
                  width: 85.w,
                  child: Column(
                    children: [
                      Avatar(user: state.user),
                      MainButton(
                          text: 'New Game',
                          onPressed: () {
                            context.goNamed(RouteConstants.newGame);
                          }),
                      SizedBox(height: 3.07.h),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Last winner drawings",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.07.h),
                      BlocBuilder<DrawingsBloc, DrawingsState>(
                        builder: (context, state) {
                          return SizedBox(
                            child: state.status == DrawingsStatus.loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.myDrawings.length,
                                    itemBuilder: (context, index) {
                                      return DrawingTab(imageUrl: state.myDrawings[index].imageUrl);
                                    },
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
