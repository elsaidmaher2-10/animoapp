import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/HaveAccountORLogin.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Lname.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Phone.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/fname.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/signupbutton.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resource/constantsmanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

class Singnup extends StatefulWidget {
  const Singnup({super.key});

  @override
  State<Singnup> createState() => _SingnupState();
}

class _SingnupState extends State<Singnup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screeutilsManager.h30),

                  Center(
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

                  SizedBox(height: screeutilsManager.h30),

                  /// First Name
                  Fname(
                    controller: fnameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter first name";
                      }
                      return null;
                    },
                  ),

                  /// Last Name
                  Lname(
                    controller: lnameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter last name";
                      }
                      return null;
                    },
                  ),

                  /// Email
                  Email(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                  ),

                  /// Phone
                  Phone(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter phone number";
                      }
                      return null;
                    },
                  ),

                  /// Password
                  Password(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                  ),

                  const PasswordRules(),

                  /// Confirm Password
                  ConfirmPassword(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),

                  Uploadimage(),

                  SizedBox(height: screeutilsManager.h30),

                  /// Sign Up Button
                  SignUPButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint("✅ Form Valid");
                        debugPrint("First Name: ${fnameController.text}");
                        debugPrint("Email: ${emailController.text}");
                      }
                    },
                  ),

                  HaveAccountORLogin(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  SizedBox(height: screeutilsManager.h30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
