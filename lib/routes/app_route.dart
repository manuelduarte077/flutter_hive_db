import 'package:flutter/material.dart';

import 'package:flutter_hive_db/screens/screens.dart';
import 'package:flutter_hive_db/utils/error_route.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The route name is ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case '/login':
        return LoginScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const ErrorRoutes(),
    );
  }
}
