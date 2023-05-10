import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: widget.tabs,
        onTap: (index) => _onItemTapped(context, index),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black,
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
