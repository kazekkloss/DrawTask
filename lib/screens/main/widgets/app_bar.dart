import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  State<TopAppBar> createState() => _TopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopAppBarState extends State<TopAppBar> {
  bool _isLeading = false;
  String _title = 'DrawTask';
  late GoRouter _router;

  final List<String> mainLocation = [
    "/games",
    "/home",
    "/new_game",
    "/profile",
  ];

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
    if (_router.location == "/new_game/friends_game") {
      setState(() {
        _isLeading = true;
        _title = "Friend's Game";
      });
    } else if (mainLocation.contains(_router.location)) {
      setState(() {
        _isLeading = false;
        _title = "DrawTask";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      leading: _isLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            )
          : null,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      title: Text(
        _title,
        style: TextStyle(
            fontSize: 2.8.h, fontFamily: 'IrishGrover', color: Colors.black),
      ),
    );
  }
}
