import 'dart:async';

import 'package:animoapp/core/function/passvlidatorrules.dart';
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/view/widget/otpappbar.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  StreamController<List> streamController = StreamController.broadcast();
  bool isvalid = false;
  @override
  void initState() {
    super.initState();

    _confirmPasswordController.addListener(matchpassword);
    _passwordController.addListener(matchpassword);

    // _confirmPasswordController.addListener(matchpassword);
  }

  void matchpassword() {
    setState(() {
      print(isvalid);
      isvalid =
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: otpappbar(context, () {
        Navigator.pop(context);
      }),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 18.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  constantManager.createnewpass,
                  style: TextStyle(
                    fontFamily: FontFamily.Otama_ep,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.kprimary,
                  ),
                ),
                SizedBox(height: screeutilsManager.h10),

                Password(
                  text: constantManager.newPassword,
                  controller: _passwordController,
                  onChanged: (String value) {
                    streamController.add(passwordvalidatorrules(value));
                  },
                ),
                const SizedBox(height: 16),
                PasswordRules(streamController: streamController),
                const SizedBox(height: 8),
                ConfirmPasswordwiget(
                  controller: _confirmPasswordController,
                  validator: (String? p1) {
                    if (p1 == null || p1.isEmpty) {
                      return "Enter confirm password";
                    }
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return "Passwords do not match";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: isvalid ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManger.kprimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      constantManager.submit,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
