import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';
import '../../config/config.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
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
                  // const CircularProgressIndicator(
                  //   color: Colors.black,
                  // )
                  ElevatedButton(
                    onPressed: () {
                      // context.read<UsersBloc>().add(GetUsersEvent(
                      //     friendsType: FriendsType.accepted, context: context));
                    },
                    child: const Text('test button'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
