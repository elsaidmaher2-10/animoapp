import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Uploadimage extends StatelessWidget {
  const Uploadimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Image For Your Profile",
          style: TextStyle(fontSize: 16.sp, color: Color(0xff505050)),
        ),
    
        SizedBox(height: 8.h),
        DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(8),
            dashPattern: [10, 5],
            strokeWidth: 2,
            padding: EdgeInsets.all(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 67),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage(AssetValueManager.uploadimage),
                        height: 30,
                      ),
                      SizedBox(height: 16.sp),
                      Text(
                        "Select file",
                        style: TextStyle(color: ColorManger.kprimary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
