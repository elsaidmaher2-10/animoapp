
import 'dart:io';

import 'package:animoapp/core/function/imagebutton.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/service/imagepickerservice.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

void showSignupImageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (ctx) => Wrap(
      children: [
        Appbutton(
          onPressed: () async {
            File? image = await imagepickerservice(
              context,
              ImageSource.gallery,
            );
            context.read<SingupCubit>().imagepickerstate(image);
            Navigator.pop(ctx);
          },
          text: constantManager.photoGallery,
        ),

        Divider(height: 2, color: ColorManger.white, thickness: 2),

        Appbutton(
          onPressed: () async {
            File? image = await imagepickerservice(context, ImageSource.camera);
            context.read<SingupCubit>().imagepickerstate(image);
            Navigator.pop(ctx);
          },
          text: constantManager.camera,
        ),

        SizedBox(height: 10.h),

        Appbutton(
          onPressed: () => Navigator.pop(ctx),
          color: ColorManger.white,
          text: constantManager.cancel,
        ),
      ],
    ),
  );
}
