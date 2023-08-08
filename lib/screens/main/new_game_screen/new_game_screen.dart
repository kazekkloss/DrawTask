import 'package:drawtask/screens/main/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import 'widgets/new_game_tab.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  bool show = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        show = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Avatar(user: state.user),
                ),
              ),
              AnimatedPositioned(
                bottom: show ? 0 : -54.8.h + 64,
                curve: Curves.linearToEaseOut,
                duration: const Duration(milliseconds: 1000),
                child: const NewGameTab(),
              )
            ],
          ),
        );
      },
    );
  }
}
