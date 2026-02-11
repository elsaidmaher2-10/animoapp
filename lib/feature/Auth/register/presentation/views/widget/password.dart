import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/visblitypassword/visibleeye_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Password extends StatelessWidget {
  Password({
    super.key,
    required this.controller,
    required this.onChanged,
    this.text = constantManager.pass,
  });
  String text;
  TextEditingController controller;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: ColorManger.Lightgrey,
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: screeutilsManager.h6),
        BlocProvider(
          create: (BuildContext context) => VisibleeyeCubit(),
          child: BlocBuilder<VisibleeyeCubit, bool>(
            builder: (BuildContext context, state) {
              return CustomTextfromfield(
                onChanged: onChanged,
                controller: controller,
                obstext: state,
                hinttext: constantManager.hinytextpass,
                suffix: IconButton(
                  onPressed: () {
                    context.read<VisibleeyeCubit>().chanagevisbilitypassword();
                  },
                  icon: Icon(
                    state == true ? Icons.remove_red_eye : Icons.visibility_off,
                    color: ColorManger.Lightgrey2,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
