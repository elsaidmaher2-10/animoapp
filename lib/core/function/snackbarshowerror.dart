import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required VoidCallback onRetry,

    Color backgroundcolor = const Color(0xff04332D),
    Duration duration = const Duration(seconds: 5),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: message == constantManager.Nointernetconnection
            ? SnackBarAction(
                label: constantManager.retry,
                onPressed: onRetry,
                textColor: ColorManger.white,
              )
            : null,
        duration: Duration(seconds: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        backgroundColor: backgroundcolor,
        dismissDirection: DismissDirection.endToStart,
        content: Text(
          message,
          style: TextStyle(
            color: ColorManger.white,
            fontSize: screeutilsManager.h16,
          ),
        ),
      ),
    );
  }
}
