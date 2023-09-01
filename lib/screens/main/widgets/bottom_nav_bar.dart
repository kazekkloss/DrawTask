import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../cubits/cubits.dart';
import 'widgets.dart';

class BottomNavBar extends StatefulWidget {
  final Widget child;
  final List<NavBarItem> tabs;
  const BottomNavBar({super.key, required this.child, required this.tabs});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
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

  bool gameWords = false;

  // Settings to appBar. if there are gameWords in the appbar, they must disable it to call the appBar in the screen file

  late GoRouter _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _router = GoRouter.of(context);
    _router.addListener(() {
      if (mounted) {
        settingsAppBar();
      }
    });
  }

  @override
  void dispose() {
    _router.removeListener(settingsAppBar);
    super.dispose();
  }

  void settingsAppBar() {
    switch (_router.location) {
      case "/dashboard/game":
        setState(() {
          gameWords = true;
        });
        break;
      case "/dashboard/game/vote":
        setState(() {
          gameWords = true;
        });
        break;
      case "/dashboard/score":
        setState(() {
          gameWords = true;
        });
        break;
      default:
        setState(() {
          gameWords = false;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: !gameWords ? TopAppBar(scaffoldKey: scaffoldKey) : null,
      body: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: const CustomDrawer(),
        drawerEnableOpenDragGesture: false,
        body: widget.child,
        bottomNavigationBar: Container(
          height: 64,
          decoration: const BoxDecoration(
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
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
                            height: 15,
                            width: 25.w,
                            color: state.themeData.primaryColor,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            height: 17,
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
