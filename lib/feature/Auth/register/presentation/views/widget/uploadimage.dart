import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Uploadimage extends StatelessWidget {
  const Uploadimage({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupCubit, SingupState>(
      builder: (context, state) {
        Widget imageWidget;

        if (state is Singupimageselected) {
          imageWidget = Image.file(
            state.image,
            fit: BoxFit.fill,
            height: 300.h,
            width: 250.w,
          );
        } else if (state is Singupimagedosentselected) {
          imageWidget = Icon(
            Icons.upload_file,
            color: ColorManger.red,
            size: 40,
          );
        } else {
          imageWidget = Image.asset(
            height: 30,
            AssetValueManager.uploadimage,

            fit: BoxFit.contain,
          );
        }

        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Upload Image For Your Profile",
                  style: TextStyle(fontSize: 16.sp, color: Color(0xff505050)),
                ),
              ),

              SizedBox(height: 8.h),

              Align(
                alignment: AlignmentGeometry.topCenter,
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: state is Singupimageselected
                        ? ColorManger.green
                        : state is Singupimagedosentselected
                        ? ColorManger.red
                        : ColorManger.kprimary,
                    radius: Radius.circular(8),
                    dashPattern: [10, 5],
                    strokeWidth: 2,
                    padding: EdgeInsets.all(12.h),
                  ),
                  child: InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: state is SingupimageInitial ? 64 : 0,
                        vertical: state is SingupimageInitial ? 32 : 0,
                      ),
                      child: Column(
                        children: [
                          imageWidget,

                          state is Singupimageselected
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    SizedBox(height: 16.sp),
                                    Text(
                                      "Select file",
                                      style: TextStyle(
                                        color: ColorManger.kprimary,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
