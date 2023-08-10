import 'package:drawtask/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final List<String>? gameWords;
  const TopAppBar({super.key, this.gameWords, this.scaffoldKey});

  @override
  State<TopAppBar> createState() => _TopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _TopAppBarState extends State<TopAppBar> {
  bool _isLeading = false;
  String _title = 'DrawTask';
  late GoRouter _router;

  bool openDrawer = false;

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
      case "/new_game":
        setState(() {
          _isLeading = false;
          _title = "New Game";
        });
        break;
      case "/new_game/friends_game":
        setState(() {
          _isLeading = true;
          _title = "Friend's Game";
        });
        break;
      case "/dashboard/game":
        setState(() {
          _isLeading = true;
          _title = "Vote";
        });
        break;
      case "/dashboard/zoom":
        setState(() {
          _isLeading = true;
        });
        break;
      case "/dashboard/score":
        setState(() {
          _isLeading = true;
          _title = "Score";
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
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Container(
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
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 35,
                    child: widget.gameWords != null
                        ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.gameWords!.map((word) {
                                  return Text(
                                    " #$word ",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Righteous',
                                      color: Colors.black,
                                    ),
                                  );
                                }).toList())
                            .animate()
                            .shimmer(
                                duration: 2000.ms,
                                color: state.themeData.primaryColor)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 29),
                                child: _isLeading
                                    ? GestureDetector(
                                        onTap: () {
                                          context.pop();
                                        },
                                        child: SvgPicture.asset(
                                          'assets/svg/arrow_back.svg',
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          if (widget.scaffoldKey!.currentState!
                                              .isDrawerOpen) {
                                            setState(() {
                                              openDrawer = false;
                                            });
                                            widget.scaffoldKey!.currentState!
                                                .closeDrawer();
                                          } else {
                                            setState(() {
                                              openDrawer = true;
                                            });
                                            widget.scaffoldKey!.currentState!
                                                .openDrawer();
                                          }
                                        },
                                        child: SizedBox(
                                          width: 35,
                                          child: SvgPicture.asset(
                                            openDrawer
                                                ? 'assets/svg/arrow_back.svg'
                                                : 'assets/svg/hamburger.svg',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                              ),
                              Text(
                                _title,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Righteous',
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 64,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
