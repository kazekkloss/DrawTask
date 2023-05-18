import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';
import '../../config/config.dart';
import '../../models/models.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    User user = authBloc.state.user;
    context.read<UserBloc>().add(GetUsersEvent(
        friends: user.friends!,
        invitationsToMe: user.invitationsToMe!,
        invitationsFromMe: user.invitationsFromMe!,
        context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UsersStatus.loaded) {
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
                  SizedBox(
                    height: 13.h,
                  ),
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
