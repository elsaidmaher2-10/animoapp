import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          constantManager.pass,
          style: TextStyle(
            color: ColorManger.Lightgrey,
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          controller: TextEditingController(),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please Enter password";
            } else {
              return null;
            }
          },
          obstext: true,
          hinttext: constantManager.hinytextpass,
          suffix: Icon(Icons.remove_red_eye, color: ColorManger.Lightgrey3),
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
