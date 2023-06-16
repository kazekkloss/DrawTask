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
      case "/new_game/friends_game":
        setState(() {
          _isLeading = true;
          _title = "Friend's Game";
        });
        break;
      case "/dashboard/game":
        setState(() {
          _isLeading = true;
          _title = "Game Screen";
        });
        break;
      case "/profile/user":
        setState(() {
          _isLeading = true;
          _title = "DrawTask";
        });
        break;
      default:
        setState(() {
          _isLeading = false;
          _title = "DrawTask";
        });
        break;
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
