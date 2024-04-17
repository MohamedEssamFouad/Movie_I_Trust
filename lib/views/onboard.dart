import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../controller/controller.dart';
import '../model/contentONboard.dart';
import 'HomeScreen.dart';
import '../model/consts.dart';
import '../model/OnboardAssets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoardSc extends StatelessWidget {
  final Controller controller = Get.put(Controller());

  late PageController _controller;

  List<ContentOnboard> contents = [
    ContentOnboard("Now you can more quickly and easily note your movie into your watchlist!"),
    ContentOnboard("Easy to add and maintain."),
    ContentOnboard("Imagine your life without the app."),
  ];

  @override
  Widget build(BuildContext context) {
    _controller = PageController(initialPage: 0);

    return Scaffold(
      backgroundColor: consts.myColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.sp),
                child: Text(
                  'Movie I Trust',
                  style: TextStyle(
                    fontSize: 30.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: consts.white,
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.sh, // Use half of screen height for the PageView
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Column(
                        children: [
                          Image.asset(
                            OnboardAssets.images[index],
                            width: 1.sw - 40.sp, // Take full screen width minus padding
                            height: 200.h, // Fixed height for images
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            contents[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 15.sp, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: consts.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Obx(
                ()=> Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                        (index) => buildDot(index, context),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 20.sp),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.currentIndex.value == contents.length - 1) {
                      Get.offAll(() => HomeScreen());
                      completeIntro();// Ensure no back navigation to OnBoarding
                    } else {
                      _controller.nextPage(
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
                    controller.currentIndex.value == contents.length - 1 ? "Get Started" : "Next",
                    style: TextStyle(
                      color: consts.myColor,
                      fontSize: 18.sp, // Responsive font size
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
  Future<void>completeIntro () async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Get.off(()=>HomeScreen());
  }
}
