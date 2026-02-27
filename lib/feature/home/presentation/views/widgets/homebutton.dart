import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class Homebutton extends StatelessWidget {
   Homebutton({super.key, required this.onPressed ,required this.text});
  final void Function()? onPressed;
  @override
  String text;

  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManger.kprimary,
          foregroundColor: ColorManger.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screeutilsManager.r10),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
