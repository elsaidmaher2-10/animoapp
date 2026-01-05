import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/resource/constantsmanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SvgPicture.asset(
                AssetValueManager.Klog,
                width: screeutilsManager.w72,
              ),
              Text(
                constantManager.animo,
                style: TextStyle(
                  fontSize: screeutilsManager.s11,
                  color: ColorManger.kprimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
