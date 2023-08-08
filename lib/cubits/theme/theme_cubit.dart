import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
            ThemeState(themeData: defaultTheme, textButtonColor: defaultColor));

  static ThemeData defaultTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 51, 51, 51),
      splashColor: const Color.fromARGB(255, 81, 81, 81));
  static Color defaultColor = const Color.fromARGB(255, 255, 255, 255);

  void updateAvatarColor(String avatar) {
    if (avatar.isNotEmpty) {
      late Color primaryColor;
      late Color splashColor;
      switch (avatar) {
        case 'assets/avatars/green_avatar.json':
          primaryColor = const Color.fromRGBO(96, 190, 191, 1);
          splashColor = const Color.fromRGBO(83, 154, 155, 1);
          break;
        case 'assets/avatars/grey_avatar.json':
          primaryColor = const Color.fromRGBO(217, 217, 217, 1);
          splashColor = const Color.fromRGBO(152, 152, 152, 1);
          break;
        case 'assets/avatars/pink_avatar.json':
          primaryColor = const Color.fromRGBO(255, 191, 218, 1);
          splashColor = const Color.fromRGBO(179, 134, 153, 1);
          break;
        case 'assets/avatars/purple_avatar.json':
          primaryColor = const Color.fromRGBO(210, 184, 245, 1);
          splashColor = const Color.fromRGBO(147, 128, 172, 1);
          break;
      }

      emit(ThemeState(
          themeData:
              ThemeData(primaryColor: primaryColor, splashColor: splashColor),
          textButtonColor: const Color.fromARGB(255, 51, 51, 51)));
    } else {
      emit(ThemeState(themeData: defaultTheme, textButtonColor: defaultColor));
    }
  }
}
