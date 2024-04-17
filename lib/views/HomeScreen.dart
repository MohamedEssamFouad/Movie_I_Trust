import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:note_movie_app/controller/controller.dart';
import 'package:note_movie_app/model/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Add_Movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find<Controller>();

    return Scaffold(
      backgroundColor: consts.myColor,
      appBar: AppBar(
        title: Text('Movie I Trust Watchlist',style: TextStyle(
          color: consts.white,
        ),),
        centerTitle: true,
        backgroundColor: consts.myColor,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.results.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'There are no movies added. Start adding to your watchlist!',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: consts.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }else
          return
            GridView.builder(
              itemCount: controller.results.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: Image.memory(imageBytes, fit: BoxFit.cover),
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
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
                                    }, icon: Icon(Icons.share,color: Colors.white,)),
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

        },
          ),



        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => Add_Movie()),
        child: Icon(Icons.add, color: consts.myColor),
        backgroundColor: consts.white,
        elevation: 100,
      ),
    );
  }
}
