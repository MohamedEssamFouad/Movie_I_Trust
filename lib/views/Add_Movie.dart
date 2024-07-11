import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_movie_app/model/consts.dart';
import 'package:note_movie_app/views/HomeScreen.dart';
import 'package:note_movie_app/controller/controller.dart';
import 'package:note_movie_app/views/uploadPart.dart';
import 'package:note_movie_app/views/widget/buildTextField.dart';
import 'package:note_movie_app/views/widget/validateFields.dart';

class Add_Movie extends StatelessWidget {
  const Add_Movie({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find<Controller>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: consts.myColor,
          iconTheme: IconThemeData(
            color: consts.white,
          ),
          title: Text('Add Your Movie Details',style: TextStyle(
            color: consts.white,
          ),),
          centerTitle: true,
        ),
        backgroundColor: consts.myColor,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                   SecondPartUploadAndPick(),
                  SizedBox(height: 20.h),
                  buildTextField(context, controller.nameController, "Movie Name"),
                  SizedBox(height: 20.h),
                  buildTextField(context, controller.genreController, "Movie Genre"),
                  SizedBox(height: 20.h),
                  buildTextField(context, controller.noteController, "Note"),
                  SizedBox(height: 50.h),
                  GestureDetector(
                    onTap: () {
                      if (validateFields(context, controller)) {
                        controller.saveMovieDetails();
                        controller.nameController.clear();
                        controller.genreController.clear();
                        controller.noteController.clear();
                        Get.offAll(() => const HomeScreen());
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: consts.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 200.w,
                      height: 60.h,
                      child: Text(
                        'Add To Watchlist',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: consts.myColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }





}
