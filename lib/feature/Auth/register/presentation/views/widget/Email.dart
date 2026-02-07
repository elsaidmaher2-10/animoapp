import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  Email({super.key, required this.controller, required this.validator});
  TextEditingController controller;
  String? Function(String?)? validator;
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
          ktype: TextInputType.emailAddress,
          controller: controller,
          hinttext: constantManager.hinytextemail,
          validator: validator,
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
