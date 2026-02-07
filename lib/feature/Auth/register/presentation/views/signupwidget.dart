import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:animoapp/core/function/passvlidatorrules.dart';
import 'package:animoapp/core/function/sinupvalidator.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/Auth/register/data/models/usermodel.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/ValidatebuttonCubit/validatebutton_cubit.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/cubit/signupcontroller_cubit.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/HaveAccountORLogin.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/errorsnackbar.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Lname.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Phone.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/fname.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/showmodalbottomsheetimage.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/signupbutton.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/signuplogo.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/uploadimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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

  ValueNotifier<bool> isFormValid = ValueNotifier(false);
  StreamController<List> streamController = StreamController();
  File? image;
  Usermodel? usermodel;
  @override
  @override
  void initState() {
    super.initState();

    void listener() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isFormValid.value =
            fnameController.text.isNotEmpty &&
            lnameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;
      });
    }

    fnameController.addListener(listener);
    lnameController.addListener(listener);
    emailController.addListener(listener);
    passwordController.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SingupCubit>(
          create: (BuildContext context) => SingupCubit(),
        ),
        BlocProvider<SignupcontrollerCubit>(
          create: (BuildContext context) => SignupcontrollerCubit(),
        ),

        BlocProvider<ValidatebuttonCubit>(
          create: (BuildContext context) => ValidatebuttonCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocConsumer<SignupcontrollerCubit, SignupcontrollerState>(
            listener: (context, state) async {
              if (state is Signupcontrollerfailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action:
                        state.message == constantManager.Nointernetconnection
                        ? SnackBarAction(
                            label: constantManager.retry,
                            onPressed: () {
                              context.read<SignupcontrollerCubit>().signupfunc(
                                usermodel!,
                              );
                            },
                          )
                        : null,
                    duration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 232, 63, 63),
                    dismissDirection: DismissDirection.endToStart,
                    content: Text(
                      state.message,
                      style: TextStyle(
                        color: ColorManger.white,
                        fontSize: screeutilsManager.h16,
                      ),
                    ),
                  ),
                );
              }
              if (state is Signupcontrollersucess) {
                await showDialog(
                  context: context,
                  barrierDismissible: false, // المستخدم ميقدرش يقفلها بالسهو
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // حواف مدورة
                    ),
                    backgroundColor: Colors.white,
                    title: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: ColorManger.kprimary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "OTP Sent",
                          style: TextStyle(
                            color: ColorManger.kprimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    content: Text(
                      "We have sent an OTP code to your registered email or phone.",
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // تقفل الديالوج
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: ColorManger.kprimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              Navigator.pushNamed(context, RouteName.otpverficationc);
            },
            buildWhen: (previous, current) {
              return current is Signupcontrollerloading ||
                  current is Signupcontrollerfailure;
            },
            builder: (context, state) {
              log(state.toString());
              bool isasync = false;
              if (state is Signupcontrollerloading) {
                isasync = true;
              } else {
                isasync = false;
              }
              return ModalProgressHUD(
                inAsyncCall: isasync,

                blur: 15,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 15,
                  color: ColorManger.kprimary,
                ),
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
                                  signuplogo(),
                                  SizedBox(height: screeutilsManager.h30),
                                  Fname(
                                    controller: fnameController,
                                    validator: fnamevalidator,
                                  ),
                                  Lname(
                                    controller: lnameController,
                                    validator: lnamevalidator,
                                  ),
                                  Email(
                                    controller: emailController,
                                    validator: emailvalidator,
                                  ),
                                  Phone(
                                    controller: phoneController,
                                    validator: phonevalidator,
                                  ),

                                  /// Password
                                  Password(
                                    controller: passwordController,
                                    onChanged: (value) {
                                      streamController.add(
                                        passwordvalidatorrules(value),
                                      );
                                    },
                                  ),

                                  /// Password Rules
                                  PasswordRules(
                                    streamController: streamController,
                                  ),

                                  /// Confirm Password
                                  ConfirmPassword(
                                    controller: confirmPasswordController,
                                    validator: confvalidator,
                                  ),

                                  Uploadimage(
                                    onTap: () {
                                      showSignupImageBottomSheet(context);
                                    },
                                  ),

                                  SizedBox(height: screeutilsManager.h30),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: isFormValid,
                                    builder: (context, isValid, child) {
                                      final cubit = context.read<SingupCubit>();
                                      return SignUPButton(
                                        onPressed: isValid && cubit.hasImage
                                            ? () async {
                                                if (cubit.image != null) {
                                                  final imageCubit = context
                                                      .read<SingupCubit>();

                                                  usermodel = Usermodel(
                                                    firstName:
                                                        fnameController.text,
                                                    lastName:
                                                        lnameController.text,
                                                    email: emailController.text,
                                                    image: imageCubit.image!,
                                                    password:
                                                        passwordController.text,
                                                    phone: phoneController.text,
                                                  );
                                                  context
                                                      .read<
                                                        SignupcontrollerCubit
                                                      >()
                                                      .signupfunc(usermodel!);
                                                } else {
                                                  errorsnackbar(context);
                                                }
                                              }
                                            : null,
                                      );
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
            },
          );
        },
      ),
    );
  }

  String? confvalidator(value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
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
