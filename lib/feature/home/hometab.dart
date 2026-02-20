import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/home/presentation/views/home.dart';
import 'package:animoapp/feature/home/seeAll.dart';
import 'package:flutter/material.dart';

class Hometab extends StatelessWidget {
  const Hometab({super.key, required this.onTap, required this.onTap2});
  final Function()? onTap;
  final Function()? onTap2;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: getIt<GlobalKey<NavigatorState>>(
        instanceName: constantManager.seeAllKey,
      ),
      onGenerateRoute: (settings) {
        print(settings.name);
        switch (settings.name) {
          case RouteName.seeAll:
            return MaterialPageRoute(builder: (context) => SeeAll());

          default:
            return MaterialPageRoute(
              builder: (context) => Home(onTap: onTap, onTap2: onTap2),
            );
        }
      },
    );
  }
}
