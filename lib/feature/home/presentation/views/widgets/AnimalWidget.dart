import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimalWidget extends StatelessWidget {
  const AnimalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 2.h),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => Container(
        margin: EdgeInsets.all(17.w),
        decoration: BoxDecoration(color: ColorManger.Lightgrey4),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dog name",
                        style: TextStyle(
                          fontFamily: FontFamily.poppinsExtraBold,

                          color: ColorManger.black,
                          fontSize: screeutilsManager.s12,
                        ),
                      ),
                      Text(
                        "create by Ahmed El-said",
                        style: TextStyle(
                          fontSize: screeutilsManager.s12,
                          color: Color(0xff999999),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        "1000\$",
                        style: TextStyle(
                          fontFamily: FontFamily.poppinsExtraBold,
                          color: ColorManger.kprimary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    ],
                  ),
                ],
              ),
            ),

            Image.asset(
              fit: BoxFit.fill,
              "assets/image/Rectangle 45.png",
              width: double.infinity,
              height: 200,
            ),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 9.w,
                vertical: 11,
              ),
              child: Text(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManger.black,
                  fontFamily: FontFamily.OriginalSurfer,
                ),
                "I found this sweet dog and am looking for a loving home for them. If you're ready to welcome a new furry friend into your life, this adorable pup is waiting to bring joy and...",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
