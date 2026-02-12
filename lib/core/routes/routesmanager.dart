import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/core/widget/unknownRoute.dart';
import 'package:animoapp/feature/Auth/confirmpassword/presentation/view/Confirmpass.dart';
import 'package:animoapp/feature/Auth/Login/presentation/views/LoginPage.dart';
import 'package:animoapp/feature/Auth/foregetpassword/presentation/views/foregetpassword.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/view/otpvrificationcode.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/signupwidget.dart';
import 'package:flutter/material.dart';

abstract class RoutesManager {
  static Route<dynamic>? ongenerate(RouteSettings route) {
    switch (route.name) {
      case RouteName.home:
        {
          return MaterialPageRoute(builder: (ctx) => Loginpage());
        }
      case RouteName.register:
        {
          return MaterialPageRoute(builder: (ctx) => Singnup());
        }

      case RouteName.login:
        {
          return MaterialPageRoute(builder: (ctx) => Loginpage());
        }
      case RouteName.foregetpassword:
        {
          return MaterialPageRoute(builder: (ctx) => Foregetpassword());
        }
      case RouteName.otpverficationc:
        {
          return MaterialPageRoute(
            builder: (ctx) => Otpvrificationcode(),
            settings: route,

            //  مهمه جدا
          );
        }
      case RouteName.confirmPassword:
        {
          return MaterialPageRoute(
            builder: (ctx) => CreatePasswordScreen(),
            settings: route,
          );
        }
      default:
        {
          return MaterialPageRoute(builder: (ctx) => Unknownroute());
        }
    }
  }
}
