import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Homepageappbar extends StatelessWidget {
  const Homepageappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 17.w),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetValueManager.Klog,
            width: screeutilsManager.w72,
          ),
          SizedBox(width: 24.w),

          Text(
            "Hello in ANIMOOO",
            style: TextStyle(
              color: ColorManger.kprimary,
              fontSize: 24.sp,
              fontFamily: FontFamily.OriginalSurfer,
            ),
          ),
        ],
      ),
    );
  }
}
