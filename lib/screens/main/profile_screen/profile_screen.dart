import 'package:drawtask/screens/main/profile_screen/widgets/friends_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';

enum ContentType {
  accountSettings,
  drawings,
  firends,
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ContentType currentContentType = ContentType.drawings;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
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
                          InkWell(
                            splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            onTap: () {
                              setState(() {
                                currentContentType =
                                    ContentType.accountSettings;
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: currentContentType ==
                                          ContentType.accountSettings
                                      ? const Color.fromRGBO(75, 75, 75, 1.0)
                                      : const Color.fromRGBO(
                                          204, 204, 204, 1.0),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 4.7.h,
                              width: 26.9.w,
                              child: Center(
                                  child: Text(
                                'Account Settings',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentContentType ==
                                          ContentType.accountSettings
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )),
                            ),
                          ),
                          InkWell(
                            splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            onTap: () {
                              setState(() {
                                currentContentType = ContentType.drawings;
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: currentContentType ==
                                          ContentType.drawings
                                      ? const Color.fromRGBO(75, 75, 75, 1.0)
                                      : const Color.fromRGBO(
                                          204, 204, 204, 1.0),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 4.7.h,
                              width: 26.9.w,
                              child: Center(
                                  child: Text(
                                'Drawings',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      currentContentType == ContentType.drawings
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              )),
                            ),
                          ),
                          InkWell(
                            splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            onTap: () {
                              setState(() {
                                currentContentType = ContentType.firends;
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: currentContentType ==
                                          ContentType.firends
                                      ? const Color.fromRGBO(75, 75, 75, 1.0)
                                      : const Color.fromRGBO(
                                          204, 204, 204, 1.0),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 4.7.h,
                              width: 26.9.w,
                              child: Center(
                                  child: Text(
                                'Friends',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      currentContentType == ContentType.firends
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.2.h,
                    ),
                    getContentWidget()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getContentWidget() {
    switch (currentContentType) {
      case ContentType.accountSettings:
        return const Center(
          child: Text('Account Settings'),
        );
      case ContentType.drawings:
        return const Center(
          child: Text('Drawings'),
        );
      case ContentType.firends:
        return const FriendsWidget();
    }
  }
}
