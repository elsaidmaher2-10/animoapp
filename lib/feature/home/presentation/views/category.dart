import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/service/imagepickerservice.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/uploadimage.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/homebutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 18.w, vertical: 9.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create New Category",
              style: TextStyle(
                fontSize: screeutilsManager.s20,
                color: ColorManger.kprimary,
                fontFamily: FontFamily.Otama_ep,
              ),
            ),
            SizedBox(height: 12.h),

            Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundImage: AssetImage(AssetValueManager.profile),
                ),
                SizedBox(width: 6.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ahmed El-said",
                      style: TextStyle(
                        fontSize: screeutilsManager.s12,
                        color: ColorManger.black,
                        fontFamily: FontFamily.poppinsExtraBold,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorManger.klightgreen.withOpacity(0.1),
                      ),

                      child: Row(
                        children: [
                          Icon(Icons.public, color: ColorManger.klightgreen),
                          Text(
                            "Public",
                            style: TextStyle(color: ColorManger.klightgreen),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screeutilsManager.h20),
            CategoryField(
              maxlines: 1,
              text: "Category Name",
              hinttext: 'Enter your Category Name',
            ),
            SizedBox(height: screeutilsManager.h20),
            CategoryField(
              maxlines: 3,
              text: "Category Description",
              hinttext: 'Enter your Description',
            ),

            SizedBox(height: 16.h),

            BlocProvider(
              create: (BuildContext context) => SingupCubit(),
              child: Uploadimage(
                onTap: () {
                  imagepickerservice(context, ImageSource.camera);
                },
              ),
            ),
            SizedBox(height: 20.h),
            Homebutton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class CategoryField extends StatelessWidget {
  CategoryField({
    super.key,
    required this.hinttext,
    required this.text,
    this.maxlines = 1,
  });
  String text;
  String hinttext;

  int maxlines;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: const Color.fromARGB(255, 60, 60, 60),
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: 6.h),
        CustomTextfromfield(
          maxlines: maxlines,
          hinttext: hinttext,
          controller: TextEditingController(),
        ),
      ],
    );
  }
}
