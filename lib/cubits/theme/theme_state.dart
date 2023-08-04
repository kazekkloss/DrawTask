part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final Color textButtonColor;
  const ThemeState({required this.themeData, required this.textButtonColor});

  @override
  List<Object> get props => [themeData, textButtonColor];
}
