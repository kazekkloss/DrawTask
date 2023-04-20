import 'package:flutter/material.dart';

import '../screens/screens.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Route error'),
          ),
        ),
      );
  }
}
