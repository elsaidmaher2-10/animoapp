import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRules extends StatelessWidget {
  const PasswordRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          constantManager.PasswordRulestitle,
          style: TextStyle(
            fontSize: screeutilsManager.s10,
            color: ColorManger.red,
          ),
        ),

        ...constantManager.PasswordRules.map(
          (e) => Row(
            textBaseline: TextBaseline.alphabetic,
            children: [
              Icon(
                Icons.circle,
                size: screeutilsManager.s5,
                color: ColorManger.green,
              ),
              SizedBox(width: 2.sp),
              Text(
                e,
                style: TextStyle(
                  fontSize: screeutilsManager.s9,
                  color: ColorManger.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
