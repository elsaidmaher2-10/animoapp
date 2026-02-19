import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/home/presentation/views/home.dart';
import 'package:animoapp/feature/home/seeAll.dart';
import 'package:flutter/material.dart';

class Hometab extends StatelessWidget {
  const Hometab({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: getIt<GlobalKey<NavigatorState>>(
        instanceName: constantManager.seeAllKey,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (context) => Home());
          case RouteName.seeAll:
            return MaterialPageRoute(builder: (context) => SeeAll());
        }
      },
    );
  }
}
