import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:note_movie_app/views/HomeScreen.dart';
import 'package:note_movie_app/views/onboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/controller.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  bool? hasSeenIntro=prefs.getBool('hasSeenIntro')??false;
  Get.put(Controller());

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: ((context)=> MyApp(isFirstLaunch: !hasSeenIntro)),
  ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key,required this.isFirstLaunch});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child){
       return GetMaterialApp(
      debugShowCheckedModeBanner: false,
          home:  isFirstLaunch?OnBoardSc():HomeScreen(),
        );
      },

    );
  }
}

