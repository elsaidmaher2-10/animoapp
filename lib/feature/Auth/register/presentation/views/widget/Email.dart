import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          constantManager.email,
          style: TextStyle(
            color: ColorManger.Lightgrey,
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          controller: TextEditingController(),

          hinttext: constantManager.hinytextemail,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please Enter pass";
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
