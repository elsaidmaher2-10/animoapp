

import 'package:animoapp/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageAnimalList extends StatelessWidget {
  const HomepageAnimalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,

      child: ListView.separated(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 17.w, vertical: 6.h),
        scrollDirection: Axis.horizontal,
        /*indx == 0 || indx == 9
            ? Padding(padding: EdgeInsetsGeometry.all(3))
            : */
        itemBuilder: (ctx, indx) => Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 32.r,
                  backgroundImage: AssetImage("assets/image/png.png"),
                ),

                Positioned(
                  top: 0,
                  right: -10,
                  child: Badge.count(
                    padding: EdgeInsets.all(6),
                    count: 10,
                    backgroundColor: ColorManger.kprimary,
                  ),
                ),
              ],
            ),

            Text(
              "Dogs",
              style: TextStyle(color: ColorManger.black, fontSize: 16.sp),
            ),
          ],
        ),
        separatorBuilder: (ctx, index) => SizedBox(width: 12.w),
        itemCount: 10,
      ),
    );
  }
}
