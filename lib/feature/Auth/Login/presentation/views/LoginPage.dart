import 'dart:async';

import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/function/sinupvalidator.dart';
import 'package:animoapp/core/function/snackbarshowerror.dart';
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/Login/data/repo/Loginrepo.dart';
import 'package:animoapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_cubit.dart';
import 'package:animoapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/resource/constantsmanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormFieldState> key = GlobalKey();
  bool _isVisible = false;
  StreamController<bool> streamController = StreamController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  isvisible() {
    _isVisible = !_isVisible;
    streamController.add(!_isVisible);
  }

  bool isvalidpass = false;
  bool isvalidemail = false;

  StreamController<bool> btnController = StreamController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginmangerCubit(getIt<Loginrepo>()),
      child: Builder(
        builder: (context) {
          return BlocConsumer<LoginmangerCubit, LogincontrollerState>(
            listener: (context, state) {
              if (state is LogincontrollerFailure) {
                AppSnackBar.show(
                  context: context,
                  message: state.message,
                  onRetry: () {},
                );
              }
            },
            builder: (context, state) {
              bool isasync = true;
              if (state is LogincontrollerLoading) {
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
                            controller: email,

                            hinttext: constantManager.hinytextemail,
                            validator: (value) {
                              isvalidemail = emailvalidator(value) == null
                                  ? true
                                  : false;

                              btnController.add(isvalidemail && isvalidpass);
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
                          StreamBuilder(
                            stream: streamController.stream,
                            builder:
                                (
                                  BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot,
                                ) {
                                  return CustomTextfromfield(
                                    controller: password,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        isvalidpass = false;

                                        btnController.add(
                                          isvalidemail && isvalidpass,
                                        );
                                        return "Please Enter password";
                                      } else {
                                        isvalidpass = true;
                                        btnController.add(
                                          isvalidemail && isvalidpass,
                                        );
                                        return null;
                                      }
                                    },
                                    obstext: snapshot.data ?? false,
                                    hinttext: constantManager.hinytextpass,
                                    suffix: IconButton(
                                      onPressed: () {
                                        isvisible();
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: ColorManger.Lightgrey3,
                                      ),
                                    ),
                                  );
                                },
                          ),

                          Padding(padding: EdgeInsets.all(2.h)),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.foregetpassword,
                                );
                              },
                              child: Text(
                                constantManager.forgetPassword,
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

                            child: StreamBuilder<bool>(
                              initialData: false,
                              stream: btnController.stream,
                              builder:
                                  (
                                    BuildContext context,
                                    AsyncSnapshot<bool> snapshot,
                                  ) => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManger.kprimary,
                                      foregroundColor: ColorManger.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          screeutilsManager.r10,
                                        ),
                                      ),
                                    ),
                                    onPressed: snapshot.data == true
                                        ? () {
                                            // if (key.currentState?.validate() ?? false) {
                                            context
                                                .read<LoginmangerCubit>()
                                                .login(
                                                  email: email.text,
                                                  password: password.text,
                                                );
                                          }
                                        : null,
                                    child: Text(constantManager.logIn),
                                  ),
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
                                Navigator.of(
                                  context,
                                ).pushNamed(RouteName.register);
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
