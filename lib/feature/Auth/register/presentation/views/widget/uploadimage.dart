import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Uploadimage extends StatelessWidget {
  Uploadimage({super.key, required this.onTap, required this.edit, this.image});
  final bool edit;
  final VoidCallback onTap;
  String? image;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SingupCubit()),
        BlocProvider.value(value: getIt<CategorycontrollerCubit>()),
      ],

      child: BlocBuilder<SingupCubit, SingupState>(
        builder: (context, state) {
          Widget imageWidget;

          if (state is Singupimageselected) {
            imageWidget = Image.file(
              state.image,
              fit: BoxFit.fill,
              height: 250,
              width: 250,
            );
          } else if (state is Singupimagedosentselected) {
            imageWidget = SizedBox(
              height: 200,
              width: 200,
              child: Icon(Icons.upload_file, color: ColorManger.red, size: 100),
            );
          } else {
            if (image != null) {
              imageWidget = Image.network(
                image!,
                fit: BoxFit.fill,
                height: 250,
                width: 250,
              );
            } else {
              imageWidget = Image.asset(
                AssetValueManager.uploadimage,
                height: 30,
                fit: BoxFit.contain,
              );
            }
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
                          horizontal:
                              (state is SingupimageInitial && edit == false)
                              ? 100
                              : 0,
                          vertical: state is SingupimageInitial && edit == false
                              ? 64
                              : 0,
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
                                        edit ? "" : "Select file",
                                        style: TextStyle(
                                          color:
                                              state is Singupimagedosentselected
                                              ? ColorManger.red
                                              : ColorManger.kprimary,
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
      ),
    );
  }
}
