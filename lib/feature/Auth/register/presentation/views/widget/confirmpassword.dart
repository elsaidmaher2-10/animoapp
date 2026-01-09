
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPassword extends StatelessWidget {
  const ConfirmPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          constantManager.confirmPassword,
          style: TextStyle(
            color: ColorManger.Lightgrey,
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please Enter confirm password";
            } else {
              return null;
            }
          },
          obstext: true,
          hinttext: constantManager.hinytextpass,
          suffix: Icon(Icons.remove_red_eye, color: ColorManger.Lightgrey3),
        ),

        Padding(padding: EdgeInsets.all(2.h)),
      ],
    );
  }
}
