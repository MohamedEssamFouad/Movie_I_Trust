import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_movie_app/model/consts.dart';
import 'dart:io';

import '../controller/controller.dart';


class SecondPartUploadAndPick extends StatelessWidget {
  final Controller controller=Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => GestureDetector(
          onTap: (){
            controller.pickImage();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: consts.white,
            ),
            child: controller.pickedImage.value == null
                ? Image.asset('assests/images/output-onlinegiftools (11).gif', width: 200, height: 200)
                : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25)
              ),
              child: Image.file(
                File(controller.pickedImage.value!.path),
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),
        )),

      ],
    );
  }
}
