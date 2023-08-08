import 'package:drawtask/screens/main/widgets/app_bar.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../cubits/cubits.dart';

class BottomNavBar extends StatefulWidget {
  final Widget child;
  final List<NavBarItem> tabs;
  const BottomNavBar({super.key, required this.child, required this.tabs});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _locationToTabIndex(String location) {
    final index =
        widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopAppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            GestureDetector(
              onTap: () {
                GameSocket().gameOffListener(context);
                context.read<GameBloc>().add(ClearGamesEvent());
                context.read<AuthBloc>().add(LogoutEvent(context: context));
              },
              child: const Text(
                'Log out',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
      body: widget.child,
      bottomNavigationBar: Container(
        height: 64,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: -2,
              blurRadius: 8,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Stack(
                children: [
                  BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _currentIndex,
                    items: [
                      for (var i = 0; i < widget.tabs.length; i++)
                        i == _currentIndex
                            ? BottomNavigationBarItem(
                                icon: Container(
                                  width: 25.w,
                                  height: 34,
                                  color: state.themeData.primaryColor,
                                  child: widget.tabs[i].icon,
                                ),
                                label: '')
                            : BottomNavigationBarItem(
                                icon: SizedBox(
                                    height: 34, child: widget.tabs[i].icon),
                                label: '')
                    ],
                    onTap: (index) => _onItemTapped(context, index),
                  ),
                  Positioned(
                    left: _currentIndex * 25.w,
                    child: Column(
                      children: [
                        Container(
                          height: 14,
                          width: 25.w,
                          color: state.themeData.primaryColor,
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        Container(
                          height: 16,
                          width: 25.w,
                          decoration: BoxDecoration(
                              color: state.themeData.primaryColor,
                              borderRadius: _currentIndex == 0
                                  ? const BorderRadius.only(
                                      bottomRight: Radius.circular(15))
                                  : _currentIndex == 3
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(15))
                                      : const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends BottomNavigationBarItem {
  final String initialLocation;
  const NavBarItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);
}
