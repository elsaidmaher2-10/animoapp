import 'dart:async';

import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/function/sinupvalidator.dart';
import 'package:animoapp/core/function/snackbarshowerror.dart';
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/Auth/foregetpassword/data/repo/forgetpassword.dart';
import 'package:animoapp/feature/Auth/foregetpassword/presentation/manager/cubit/loginmanger_cubit.dart';
import 'package:animoapp/feature/Auth/foregetpassword/presentation/manager/cubit/loginmanger_state.dart';
import 'package:animoapp/feature/Auth/foregetpassword/presentation/views/widget/forgetpaaswordappbar.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Foregetpassword extends StatefulWidget {
  Foregetpassword({super.key});

  @override
  State<Foregetpassword> createState() => _ForegetpasswordState();
}

class _ForegetpasswordState extends State<Foregetpassword> {
  final TextEditingController controller = TextEditingController();
  bool isvalid = false;
  StreamController<bool> streamController = StreamController();
  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Forgeppassordcontroller(getIt<Forgepasswordrepo>()),
      child:
          BlocConsumer<Forgeppassordcontroller, ForgeppassordcontrollerState>(
            listener: (context, state) {
              if (state is ForgeppassordcontrollerFailure) {
                AppSnackBar.show(
                  context: context,
                  message: state.message,
                  onRetry: () {},
                );
              }

              if (state is ForgeppassordcontrollerSuccess) {
                Navigator.of(context).pushNamed(
                  RouteName.otpverficationc,
                  arguments: {
                    constantManager.email: controller.text,
                    "screen": constantManager.forgetPasswordscreen,
                  },
                );
              }
            },
            builder: (context, state) {
              final cubit = context.watch<Forgeppassordcontroller>();
              return ModalProgressHUD(
                inAsyncCall: cubit.isasync,
                blur: 15,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 15,
                  color: ColorManger.kprimary,
                ),
                child: Scaffold(
                  backgroundColor: ColorManger.white,
                  appBar: foregetpasswordappbar(context),
                  body: Padding(
                    padding: EdgeInsets.all(18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          constantManager.forgetPassword,
                          style: TextStyle(
                            color: ColorManger.kprimary,
                            fontSize: screeutilsManager.s20,
                            fontFamily: FontFamily.Otama_ep,
                          ),
                        ),

                        SizedBox(height: screeutilsManager.h6),

                        Text(
                          constantManager.descpriptionofforgetpass,
                          style: TextStyle(
                            color: ColorManger.Lightgrey2,
                            fontSize: screeutilsManager.s14,
                          ),
                        ),

                        SizedBox(height: screeutilsManager.h58),

                        Email(
                          controller: controller,
                          validator: (value) {
                            isvalid = emailvalidator(value) == null
                                ? true
                                : false;

                            streamController.add(isvalid);
                          },
                        ),

                        SizedBox(height: screeutilsManager.h151),
                        StreamBuilder(
                          initialData: false,
                          stream: streamController.stream,
                          builder:
                              (
                                BuildContext context,
                                AsyncSnapshot<dynamic> snapshot,
                              ) => SizedBox(
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
                                  onPressed: snapshot.data == false
                                      ? null
                                      : () {
                                          context
                                              .read<Forgeppassordcontroller>()
                                              .forgepassword(
                                                email: controller.text,
                                              );
                                        },
                                  child: Text(constantManager.sendcode),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
