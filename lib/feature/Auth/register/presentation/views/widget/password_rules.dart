import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRules extends StatefulWidget {
  const PasswordRules({super.key});

  @override
  State<PasswordRules> createState() => _PasswordRulesState();
}

class _PasswordRulesState extends State<PasswordRules> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: unrelated_type_equality_checks
        constantManager.PasswordRules.any((e) => e["status"] == false) == true
            ? Text(
                constantManager.PasswordRulestitle,
                style: TextStyle(
                  fontSize: screeutilsManager.s10,
                  color: ColorManger.red,
                ),
              )
            : SizedBox(),

        ...constantManager.PasswordRules.map(
          (e) => Row(
            textBaseline: TextBaseline.alphabetic,
            children: [
              Icon(
                Icons.circle,
                size: screeutilsManager.s5,
                color: e["status"] == true
                    ? ColorManger.green
                    : ColorManger.red,
              ),
              SizedBox(width: 2.sp),
              Text(
                e["title"],

                style: TextStyle(
                  decoration: e["status"] == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: screeutilsManager.s9,
                  color: e["status"] == true
                      ? ColorManger.green
                      : ColorManger.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
