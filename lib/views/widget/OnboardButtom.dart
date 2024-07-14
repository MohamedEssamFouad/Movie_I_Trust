import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Updated import

import '../../controller/controller.dart';
import '../../model/contentONboard.dart';
import '../HomeScreen.dart';
import 'buildDot.dart';
import '../../model/consts.dart'; // Import consts

class OnboardButtom extends StatelessWidget {
  final Controller controller;
  final PageController pageController;

  const OnboardButtom({
    required this.controller,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 20.sp),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (controller.currentIndex.value == ContentOnboard.contents.length - 1) {
            Get.offAll(() => HomeScreen());
            controller.completeIntro();
          } else {
            pageController.nextPage(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: consts.white, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.sp),
          ),
        ),
        child: Obx(() => Text(
          controller.currentIndex.value == ContentOnboard.contents.length - 1 ? "Get Started" : "Next",
          style: TextStyle(
            color: consts.myColor,
            fontSize: 18.sp,
          ),
        )),
      ),
    );
  }
}
