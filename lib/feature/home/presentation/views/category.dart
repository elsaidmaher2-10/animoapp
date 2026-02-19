import 'dart:async';

import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/showmodalbottomsheetimage.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/uploadimage.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/homebutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

TextEditingController categroynamecontroller = TextEditingController();
TextEditingController categryDescontroller = TextEditingController();
StreamController<bool> streamController = StreamController();

class _CategoryState extends State<Category> {
  bool isvalid = false;
  @override
  void initState() {
    categroynamecontroller.addListener(isvalidc);
    categryDescontroller.addListener(isvalidc);
    super.initState();
  }

  isvalidc() {
    isvalid =
        categroynamecontroller.text.isNotEmpty &&
        categryDescontroller.text.isNotEmpty &&
        categroynamecontroller.text.length > 12 &&
        categryDescontroller.text.length > 200;

    streamController.add(isvalid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 18.w, vertical: 9.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                constantManager.createnewcategory,
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
                        ),
                      ),
                      SizedBox(height: 4.h),

                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            screeutilsManager.r8,
                          ),
                          color: ColorManger.klightgreen.withOpacity(0.03),
                        ),

                        child: Row(
                          children: [
                            Icon(Icons.public, color: ColorManger.klightgreen),
                            SizedBox(width: 2.w),
                            Text(
                              constantManager.public,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return constantManager.categorynameh;
                  }
                  if (value.length <= 12) {
                    return "Value must be 12 char";
                  }
                  return null;
                },
                controller: categroynamecontroller,
                maxlines: 1,
                text: constantManager.categoryname,
                hinttext: constantManager.categorynameh,
              ),
              SizedBox(height: screeutilsManager.h20),
              CategoryField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return constantManager.categorydesch;
                  }
                  if (value.length < 200) {
                    return "Value must be More Than char";
                  }
                  return null;
                },
                controller: categryDescontroller,
                maxlines: 3,
                text: constantManager.categorydesc,
                hinttext: constantManager.categorydesch,
              ),
              SizedBox(height: screeutilsManager.h16),
              BlocProvider(
                create: (BuildContext context) => SingupCubit(),
                child: Builder(
                  builder: (BuildContext context) => Uploadimage(
                    onTap: () {
                      showSignupImageBottomSheet(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: screeutilsManager.h20),
              StreamBuilder(
                initialData: false,
                stream: streamController.stream,
                builder: (context, asyncSnapshot) {
                  return Homebutton(
                    onPressed: asyncSnapshot.data == true ? () {} : null,
                  );
                },
              ),
            ],
          ),
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
    required this.controller,
    required this.validator,
    this.maxlines = 1,
  });
  String text;
  String hinttext;
  TextEditingController controller;
  int maxlines;
  Function(String)? onChanged;
  String? Function(String?)? validator;
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
          validator: validator,
          onChanged: onChanged,
          maxlines: maxlines,
          hinttext: hinttext,
          controller: controller,
        ),
      ],
    );
  }
}
