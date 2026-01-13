import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Lname.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Phone.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/fname.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resource/constantsmanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

class Singnup extends StatefulWidget {
  Singnup({super.key});

  @override
  State<Singnup> createState() => _LoginpageState();
}

class _LoginpageState extends State<Singnup> {
  GlobalKey<FormFieldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: key,
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
                          constantManager.sinup,
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
                ),
                Fname(),
                Lname(),
                Email(),
                Phone(),
                Password(),
                PasswordRules(),
                ConfirmPassword(),
                Uploadimage()
                ,SizedBox(height: screeutilsManager.h30),
                SizedBox(
                  width: double.infinity,
            
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManger.kprimary,
                      foregroundColor: ColorManger.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          screeutilsManager.r10,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(constantManager.sinup),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
