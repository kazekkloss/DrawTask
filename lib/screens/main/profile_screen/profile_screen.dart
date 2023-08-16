import 'package:drawtask/screens/main/profile_screen/content/drawings/drawings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'content/friends/friends_content.dart';

enum _ContentType {
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
  _ContentType currentContentType = _ContentType.drawings;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Column(
                  children: [
                    Avatar(user: state.user),
                    SizedBox(
                      width: 84.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextButton(
                              text: 'ACCOUNT SETTINGS',
                              fontSize: 13,
                              onTap: () {
                                setState(() {
                                  currentContentType =
                                      _ContentType.accountSettings;
                                });
                              },
                              onTapped: currentContentType ==
                                  _ContentType.accountSettings),
                          CustomTextButton(
                              text: 'DRAWINGS',
                              fontSize: 13,
                              onTap: () {
                                setState(() {
                                  currentContentType = _ContentType.drawings;
                                });
                              },
                              onTapped:
                                  currentContentType == _ContentType.drawings),
                          CustomTextButton(
                              text: 'FRIENDS',
                              fontSize: 13,
                              onTap: () {
                                setState(() {
                                  currentContentType = _ContentType.firends;
                                });
                              },
                              onTapped:
                                  currentContentType == _ContentType.firends),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.2.h,
                    ),
                    getContentWidget(),
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
      case _ContentType.accountSettings:
        return const Center(
          child: Text('Account Settings'),
        );
      case _ContentType.drawings:
        return const DrawingsWidget();
      case _ContentType.firends:
        return FriendsContent(
          onSearchResultsChanged: (value) {
            _scrollController.animateTo(
              5.h * value,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
        );
    }
  }
}
