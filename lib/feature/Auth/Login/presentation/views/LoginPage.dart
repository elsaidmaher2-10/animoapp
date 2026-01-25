import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/foregetpassword/presentation/views/foregetpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resource/constantsmanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormFieldState> key = GlobalKey();
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
              ),
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
                suffix: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: ColorManger.Lightgrey3,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(2.h)),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.foregetpassword);
                  },
                  child: Text(
                    constantManager.ForgetPassword,
                    style: TextStyle(
                      color: ColorManger.kprimary,
                      fontSize: screeutilsManager.s10,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screeutilsManager.h30),
              Container(
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
                  child: Text(constantManager.logIn),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "${constantManager.donthaveaccount} ",
                style: TextStyle(color: ColorManger.Lightgrey2),
              ),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.register);
                  },
                  child: Text(
                    constantManager.Signup,
                    style: TextStyle(color: ColorManger.kprimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
