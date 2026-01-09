import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/core/widget/unknownRoute.dart';
import 'package:animoapp/feature/Auth/Login/presentation/views/LoginPage.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/singnU.dart';
import 'package:flutter/material.dart';

abstract class RoutesManager {
  static Route<dynamic>? ongenerate(RouteSettings route) {
    switch (route.name) {
      case RouteName.Home:
        return MaterialPageRoute(builder: (ctx) => Loginpage());

      case RouteName.register:
        return MaterialPageRoute(builder: (ctx) => Singnup());
      default:
        return MaterialPageRoute(builder: (ctx) => Unknownroute());
    }
  }
}
