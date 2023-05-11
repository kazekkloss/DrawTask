import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class ProfileScreen extends StatelessWidget {
  final bool isAppBar = false;
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Column(
                children: [
                  Container(
                    height: 11.h,
                    width: 11.h,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 149, 149, 149),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    state.user.username.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 84.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 4.7.h,
                          width: 26.9.w,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(204, 204, 204, 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              'Account Settings',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 4.7.h,
                          width: 26.9.w,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(204, 204, 204, 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              'Drawings',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 4.7.h,
                          width: 26.9.w,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(204, 204, 204, 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              'Friends',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
