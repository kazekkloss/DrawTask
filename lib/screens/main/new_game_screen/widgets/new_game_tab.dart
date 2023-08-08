import 'package:drawtask/config/router/route_constants.dart';
import 'package:drawtask/screens/main/new_game_screen/widgets/new_game_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class NewGameTab extends StatelessWidget {
  const NewGameTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.8.h - 64,
      width: 100.w,
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
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              width: 100.w,
              child: ClipRRect(
                child: Transform.scale(
                  scale: 3, // Przykładowy współczynnik powiększenia
                  child: SvgPicture.asset(
                    'assets/svg/static_background.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(192, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
              ),
            ),
            width: 100.w,
            height: 100.h,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  NewGameButton(
                    textButton: "Random Player",
                    onTap: () {
                      context.goNamed(RouteConstants.joiningToGame);
                    },
                  ),
                  SizedBox(
                    height: 1.4.h,
                  ),
                  NewGameButton(
                    textButton: "Friend’s Games",
                    onTap: () => context.goNamed(RouteConstants.friendsGame),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
