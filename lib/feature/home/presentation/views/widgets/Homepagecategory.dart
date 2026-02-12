
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepagecategory extends StatelessWidget {
  const Homepagecategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories ( 10 ) ",
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorManger.black,
              fontFamily: FontFamily.poppinsExtraBold,
            ),
          ),

          Text(
            "Add New Category",
            style: TextStyle(
              fontSize: 12.sp,
              color: ColorManger.black,
              fontFamily: FontFamily.poppinsExtraBold,
            ),
          ),
        ],
      ),
    );
  }
}
