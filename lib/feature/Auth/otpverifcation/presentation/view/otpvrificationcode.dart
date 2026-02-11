import 'dart:async';
import 'dart:developer';

import 'package:animoapp/core/function/snackbarshowerror.dart';
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/manager/otpvericationcontroller/otpvericationcontroller_cubit.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/manager/otpvericationcontroller/otpvericationcontroller_state.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/view/widget/otpappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Otpvrificationcode extends StatefulWidget {
  const Otpvrificationcode({super.key});

  @override
  State<Otpvrificationcode> createState() => _OtpvrificationcodeState();
}

class _OtpvrificationcodeState extends State<Otpvrificationcode> {
  late OtpvericationcontrollerCubit cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<OtpvericationcontrollerCubit>();
  }

  initState() {
    super.initState();
    context.read<OtpvericationcontrollerCubit>().init();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    return BlocConsumer<
      OtpvericationcontrollerCubit,
      OtpvericationcontrollerState
    >(
      listener: (context, state) {
        if (state is OtpvericationcontrollerFailure) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            onRetry: () {
              final otp = cubit.getOtpCode();
              if (!mounted) return;
              cubit.otpcontroller(
                email: args[constantManager.email] ?? "",
                otpcode: otp,
              );
            },
          );
        }

        if (state is OtpvericationcontrollerSuccess) {
          if (args["screen"] == "signup") {
            Navigator.pushNamed(context, RouteName.login);
          } else if (args["screen"] == constantManager.forgetPasswordscreen) {
            Navigator.pushNamed(context, RouteName.confirmPassword);
          }
        }
      },
      builder: (context, state) {
        final inAsyncCall = state is OtpvericationcontrollerLoading;

        return ModalProgressHUD(
          blur: 5,
          inAsyncCall: inAsyncCall,
          progressIndicator: CupertinoActivityIndicator(
            radius: 15,
            color: ColorManger.kprimary,
          ),
          child: Scaffold(
            backgroundColor: ColorManger.white,
            appBar: otpappbar(context, () {
              Navigator.of(context).pop();
            }),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: screeutilsManager.w18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    constantManager.oTPVerfication,
                    style: TextStyle(
                      color: ColorManger.kprimary,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.Otama_ep,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    constantManager.oTp4dgit,
                    style: TextStyle(
                      color: ColorManger.Lightgrey,
                      fontSize: 14.sp,
                      fontFamily: FontFamily.Otama_ep,
                    ),
                  ),
                  SizedBox(height: 58.h),
                  Row(
                    children: List.generate(cubit.otpLength, (index) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: TextFormField(
                            controller: cubit.controllers[index],
                            focusNode: cubit.focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            onChanged: (value) =>
                                cubit.onOtpChanged(value, index, context),
                            decoration: InputDecoration(
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 21.h),
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
                      onPressed: () {
                        final otp = cubit.getOtpCode();
                        if (!mounted) return;
                        cubit.otpcontroller(
                          email: args[constantManager.email] ?? "",
                          otpcode: otp,
                        );
                      },
                      child: const Text(constantManager.confirm),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: (cubit.counter < 60 && cubit.counter > 1)
                        ? null
                        : () {
                            if (!mounted) return;
                            cubit.resendcodetimer();
                            cubit.requestnewotpcode(
                              email: args[constantManager.email] ?? "",
                            );
                          },
                    child: StreamBuilder<int>(
                      initialData: 60,
                      stream: cubit.streamController.stream,
                      builder: (context, snapshot) {
                        final value = snapshot.data ?? 60;
                        return Center(
                          child: Text(
                            value == 60 || value == 0
                                ? constantManager.resendcode
                                : "${constantManager.resendin} 00:$value",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorManger.Lightgrey2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
