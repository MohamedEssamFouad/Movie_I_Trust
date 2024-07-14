import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../model/consts.dart'; // Import consts
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'buildDot.dart';

class PartOfHomeWidget extends StatelessWidget {
  const PartOfHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   GridView.builder(
      itemCount: controller.results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.66,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final movie = controller.results[index];
        Uint8List? imageBytes = movie['img'];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: consts.myColorButtom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageBytes != null)
                Container(
                  height: 130.h,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.memory(imageBytes, fit: BoxFit.cover),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie['movieName'] ?? 'No Title',
                        style: TextStyle(
                          color: consts.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        movie['movieGenre'] ?? 'No Genre',
                        style: TextStyle(
                          color: consts.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Text(
                          movie['note'] ?? 'No Notes',
                          style: TextStyle(
                            color: consts.white,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                          maxLines: 4,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: () => controller.deleteMovie(movie['id']), icon: Icon(Icons.delete,color: Colors.white,)),
                            IconButton(onPressed: () {
                              controller.SharePresed();
                            }, icon: const Icon(Icons.share,color: Colors.white,)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
