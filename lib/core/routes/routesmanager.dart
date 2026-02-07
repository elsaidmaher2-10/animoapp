import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/core/widget/unknownRoute.dart';
import 'package:animoapp/feature/Auth/Login/presentation/views/LoginPage.dart';
import 'package:animoapp/feature/Auth/foregetpassword/presentation/views/foregetpassword.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/view/otpvrificationcode.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/signupwidget.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
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
      case RouteName.foregetpassword:
        {
          return MaterialPageRoute(builder: (ctx) => Foregetpassword());
        }
      case RouteName.otpverficationc:
        {
          return MaterialPageRoute(builder: (ctx) => Otpvrificationcode());
        }
      case RouteName.confirmPassword:
        {
          return MaterialPageRoute(
            builder: (ctx) => ConfirmPassword(
              controller: TextEditingController(),
              validator: (String? p1) {},
            ),
          );
        }
      default:
        {
          return MaterialPageRoute(builder: (ctx) => Unknownroute());
        }
    }
  }
}
