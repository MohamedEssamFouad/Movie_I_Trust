import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_movie_app/model/consts.dart';
import 'package:note_movie_app/views/HomeScreen.dart';
import 'package:note_movie_app/controller/controller.dart';
import 'package:note_movie_app/views/uploadPart.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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

  Widget buildTextField(BuildContext context, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: consts.white,
            borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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

  bool validateFields(BuildContext context, Controller controller) {
    if (controller.nameController.text.trim().isEmpty) {
      showErrorDialog(context, 'Please enter the movie name.');
      return false;
    }
    if (controller.genreController.text.trim().isEmpty) {
      showErrorDialog(context, 'Please enter the movie genre.');
      return false;
    }
    if (controller.noteController.text.trim().isEmpty) {
      showErrorDialog(context, 'Please enter a note.');
      return false;
    }
    return true;
  }

  void showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Validation Error',
      desc: message,
      btnOkOnPress: () {},
    )..show();
  }
}
