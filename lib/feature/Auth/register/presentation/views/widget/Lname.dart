import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Lname extends StatelessWidget {
  const Lname({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          constantManager.lname,
          style: TextStyle(
            color: ColorManger.Lightgrey,
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          hinttext: constantManager.flnamehint,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please Enter Last name";
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
