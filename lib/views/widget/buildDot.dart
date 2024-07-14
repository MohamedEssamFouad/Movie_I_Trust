import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_movie_app/model/consts.dart';
import '../../controller/controller.dart';

final Controller controller = Get.find<Controller>();

Container buildDot(int index, BuildContext context) {
  return Container(
    height: 10.h,
    width: controller.currentIndex.value == index ? 25.w : 10.w,
    margin: EdgeInsets.symmetric(horizontal: 5.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.sp),
      color: controller.currentIndex.value == index ? consts.white : Colors.grey.shade600,
    ),
  );
}