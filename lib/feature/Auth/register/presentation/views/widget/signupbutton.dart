import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUPButton extends StatelessWidget {
  SignUPButton({super.key, required this.onPressed});
  void Function()? onPressed;
  @override
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
        child: Text(constantManager.sinup),
      ),
    );
  }
}
