import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/visblitypassword/visibleeye_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPassword extends StatelessWidget {
  ConfirmPassword({
    super.key,
    required this.controller,
    required this.validator,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          constantManager.confirmPassword,
          style: TextStyle(
            color: ColorManger.Lightgrey,
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: screeutilsManager.h6),
        BlocProvider(
          create: (_) => VisibleeyeCubit(),
          child: BlocBuilder<VisibleeyeCubit, bool>(
            builder: (context, state) {
              return CustomTextfromfield(
                validator: validator,
                controller: controller,
                obstext: state,
                hinttext: constantManager.hinytextpass,
                suffix: IconButton(
                  onPressed: () {
                    context
                        .read<VisibleeyeCubit>()
                        .chanagevisbilitypassword();
                  },
                  icon: Icon(
                    state
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                    color: ColorManger.Lightgrey2,
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 2.h),
      ],
    );
  }
}