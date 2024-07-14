import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/consts.dart'; // Import consts
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget buildTextField(BuildContext context, TextEditingController controller, String hintText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(
          color: consts.white,
          borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5),
          hintText: hintText,
          hintStyle: TextStyle(),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
