import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/core/routes/unknownRoute.dart';
import 'package:animoapp/feature/home/presentation/views/LoginPage.dart';
import 'package:flutter/material.dart';

abstract class RoutesManager {
  static Route<dynamic>? ongenerate(RouteSettings route) {
    switch (route.name) {
      case RouteName.Home:
        return MaterialPageRoute(builder: (ctx) => Loginpage());
      default:
        return MaterialPageRoute(builder: (ctx) => Unknownroute());
    }
  }
}
