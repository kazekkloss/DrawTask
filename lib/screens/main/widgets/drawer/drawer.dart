import 'package:drawtask/screens/main/widgets/drawer/drawer_tabs/about_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../blocs/blocs.dart';
import '../../../../cubits/cubits.dart';
import '../../../../sockets/sockets.dart';
import '../widgets.dart';

enum _ContentType { none, aboutUs, gameRules, settings, contact, logOut }

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  _ContentType currentContentType = _ContentType.none;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (_) {},
      child: Drawer(
        width: 100.w,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.h),
                        child: SizedBox(
                          height: 35.6.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomTextButton(
                                text: 'About Us',
                                onTap: () {
                                  setState(() {
                                    currentContentType = _ContentType.aboutUs;
                                  });
                                },
                                onTapped:
                                    currentContentType == _ContentType.aboutUs,
                              ),
                              CustomTextButton(
                                text: 'Game rules',
                                onTap: () {
                                  setState(() {
                                    currentContentType = _ContentType.gameRules;
                                  });
                                },
                                onTapped: currentContentType ==
                                    _ContentType.gameRules,
                              ),
                              CustomTextButton(
                                text: 'Settings',
                                onTap: () {
                                  setState(() {
                                    currentContentType = _ContentType.settings;
                                  });
                                },
                                onTapped:
                                    currentContentType == _ContentType.settings,
                              ),
                              CustomTextButton(
                                text: 'Contact',
                                onTap: () {
                                  setState(() {
                                    currentContentType = _ContentType.contact;
                                  });
                                },
                                onTapped:
                                    currentContentType == _ContentType.contact,
                              ),
                              CustomTextButton(
                                text: 'Log out',
                                onTap: () {
                                  setState(() {
                                    currentContentType = _ContentType.logOut;
                                  });
                                  GameSocket().gameOffListener(context);
                                  context
                                      .read<GameBloc>()
                                      .add(ClearGamesEvent());
                                  context
                                      .read<AuthBloc>()
                                      .add(LogoutEvent(context: context));
                                },
                                onTapped:
                                    currentContentType == _ContentType.logOut,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  bottom:
                      currentContentType == _ContentType.aboutUs ? 0 : -62.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 1000),
                  child: const AboutUs(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
