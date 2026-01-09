import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfromfield extends StatelessWidget {
  CustomTextfromfield({super.key, required this.hinttext, this.suffix});
  String hinttext;
  Icon? suffix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      decoration: InputDecoration(
        isDense: true,
        suffix: suffix,
        fillColor: Color(0xffF6F6F6),
        filled: true,
        hintText: hinttext,
        hintStyle: TextStyle(color: Color(0xff6C6C6C), fontSize: 12.sp),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff04332D), width: 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Color(0xffFC1B1A), width: 2),
        ),
      ),
    );
  }
}
