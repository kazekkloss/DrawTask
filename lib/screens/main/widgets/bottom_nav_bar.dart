import 'package:drawtask/screens/main/widgets/app_bar.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';

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
      appBar: const TopAppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            GestureDetector(
              onTap: () {
                PictureSocket().pictureOffListener(context);
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
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: -2,
            blurRadius: 8,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ], borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 35,
            currentIndex: _currentIndex,
            items: widget.tabs,
            onTap: (index) => _onItemTapped(context, index),
            selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
            unselectedItemColor: const Color.fromARGB(255, 149, 149, 149),
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
