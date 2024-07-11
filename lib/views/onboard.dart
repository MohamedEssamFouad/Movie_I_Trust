import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_movie_app/views/widget/OnboardButtom.dart';
import 'package:note_movie_app/views/widget/buildDot.dart';
import '../controller/controller.dart';
import '../model/contentONboard.dart';
import 'HomeScreen.dart';
import '../model/consts.dart';
import '../model/OnboardAssets.dart';
class OnBoardSc extends StatelessWidget {
  final Controller controller = Get.put(Controller());

  late PageController _controller;

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
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: consts.white,
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.sh,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  itemCount: ContentOnboard.contents.length,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Column(
                        children: [
                          Image.asset(
                            OnboardAssets.images[index],
                            width: 1.sw - 40.sp,
                            height: 200.h,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            ContentOnboard.contents[index].title,
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
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    ContentOnboard.contents.length,
                        (index) => buildDot(index, context),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              OnboardButtom(controller: controller, pageController: _controller), // Updated this line
            ],
          ),
        ),
      ),
    );
  }
}
