import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:note_movie_app/controller/controller.dart';
import 'package:note_movie_app/model/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_movie_app/views/widget/PartOfHomeWidget.dart';

import 'Add_Movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find<Controller>();

    return Scaffold(
      backgroundColor: consts.myColor,
      appBar: AppBar(
        title: const Text('Movie I Trust Watchlist',style: TextStyle(
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
          }else {
            return const PartOfHomeWidget();
          }

        },
          ),



        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const Add_Movie()),
        backgroundColor: consts.white,
        elevation: 100,
        child: const Icon(Icons.add, color: consts.myColor),
      ),
    );
  }
}
