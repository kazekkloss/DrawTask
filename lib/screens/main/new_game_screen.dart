import 'package:drawtask/screens/main/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  bool show = false;

  @override
  void initState() {
    setState(() {
      show = true;
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
                left: show ? 200 : 0,
                curve: Curves.linearToEaseOut,
                duration: const Duration(milliseconds: 50000),
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.amber,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
