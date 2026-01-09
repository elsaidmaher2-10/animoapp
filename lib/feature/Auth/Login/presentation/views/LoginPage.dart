import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/resource/constantsmanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AssetValueManager.Klog,
                      width: screeutilsManager.w72,
                    ),
                    Text(
                      constantManager.animo,
                      style: TextStyle(
                        fontFamily: FontFamily.OriginalSurfer,
                        fontSize: screeutilsManager.s11,
                        color: ColorManger.kprimary,
                      ),
                    ),

                    SizedBox(height: screeutilsManager.h9),

                    Text(
                      constantManager.logIn,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.Otama_ep,
                        fontSize: screeutilsManager.s38,
                        color: ColorManger.kprimary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                constantManager.email,
                style: TextStyle(
                  color: ColorManger.Lightgrey,
                  fontSize: screeutilsManager.s16,
                ),
              ),
              SizedBox(height: screeutilsManager.h6),
              CustomTextfromfield(hinttext: constantManager.hinytextemail),
              SizedBox(height: screeutilsManager.h16),

              Text(
                constantManager.pass,
                style: TextStyle(
                  color: ColorManger.Lightgrey,
                  fontSize: screeutilsManager.s16,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextfromfield(
                hinttext: constantManager.hinytextpass,
                suffix: Icon(Icons.remove_red_eye, color: Color(0xff6C6C6C)),
              ),

              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.redAccent),
                  text: "Te",
                  children: [
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          print(222);
                        },
                        child: Text("data"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
