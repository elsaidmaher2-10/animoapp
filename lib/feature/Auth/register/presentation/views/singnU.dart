import 'dart:io';

import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
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
  File? image;

  // Email validation regex
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Phone validation regex (adjust pattern based on your requirements)
  bool _isValidPhone(String phone) {
    return RegExp(
      r'^\+?[0-9]{10,15}$',
    ).hasMatch(phone.replaceAll(RegExp(r'[\s-]'), ''));
  }

  // Check if all password rules are met
  bool _arePasswordRulesMet() {
    return constantManager.PasswordRules.every(
      (rule) => rule["status"] == true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingupCubit>(
      create: (BuildContext context) => SingupCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Builder(
                  builder: (BuildContext context) {
                    return Column(
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
                            if (!_isValidEmail(value.trim())) {
                              return "Please enter a valid email address";
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
                            if (!_isValidPhone(value.trim())) {
                              return "Please enter a valid phone number";
                            }
                            return null;
                          },
                        ),

                        /// Password
                        Password(
                          controller: passwordController,
                          onChanged: (value) {
                            setState(() {
                              if (value.trim().length >= 12) {
                                constantManager.PasswordRules[0]["status"] =
                                    true;
                              } else {
                                constantManager.PasswordRules[0]["status"] =
                                    false;
                              }

                              if (value.contains(RegExp(r'[A-Z]'))) {
                                constantManager.PasswordRules[1]["status"] =
                                    true;
                              } else {
                                constantManager.PasswordRules[1]["status"] =
                                    false;
                              }

                              if (value.contains(RegExp(r'[a-z]'))) {
                                constantManager.PasswordRules[2]["status"] =
                                    true;
                              } else {
                                constantManager.PasswordRules[2]["status"] =
                                    false;
                              }

                              // رقم
                              if (value.contains(RegExp(r'[0-9]'))) {
                                constantManager.PasswordRules[4]["status"] =
                                    true;
                              } else {
                                constantManager.PasswordRules[4]["status"] =
                                    false;
                              }

                              // Special character
                              if (value.contains(
                                RegExp(
                                  r'[!@#\$%\^&\*\(\)_\+\-=\[\]{};:"\\|,.<>\/?]',
                                ),
                              )) {
                                constantManager.PasswordRules[3]["status"] =
                                    true;
                              } else {
                                constantManager.PasswordRules[3]["status"] =
                                    false;
                              }
                            });
                          },
                        ),

                        /// Password Rules
                        PasswordRules(),

                        /// Confirm Password
                        ConfirmPassword(
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),

                        Uploadimage(
                          onTap: () async {
                            XFile? file = await ImagePicker().pickImage(
                              source: ImageSource.camera,
                            );

                            if (file != null) {
                              BlocProvider.of<SingupCubit>(
                                context,
                              ).imagepickerstate(File(file.path));
                            } else {
                              {
                                BlocProvider.of<SingupCubit>(
                                  context,
                                ).imagepickerstate(null);
                              }
                            }
                          },
                        ),

                        SizedBox(height: screeutilsManager.h30),

                        /// Sign Up Button
                        SignUPButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Check if all password rules are met
                              if (!_arePasswordRulesMet()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please meet all password requirements",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              debugPrint("✅ Form Valid");
                              debugPrint("First Name: ${fnameController.text}");
                              debugPrint("Last Name: ${lnameController.text}");
                              debugPrint("Email: ${emailController.text}");
                              debugPrint("Phone: ${phoneController.text}");
                              debugPrint(
                                "Image: ${image?.path ?? 'No image selected'}",
                              );

                              // TODO: Proceed with sign up logic
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
                    );
                  },
                ),
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
