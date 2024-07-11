import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_movie_app/model/db.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/HomeScreen.dart';
class Controller extends GetxController {
  RxInt currentIndex = 0.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final RxBool hasUpload = false.obs;
  final MovieDB db = MovieDB();
  final RxList<Map<String, dynamic>> results = <Map<String, dynamic>>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchResults();
  }
  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      hasUpload.value = true;
      pickedImage.value = image;
    }
  }

  Future<void> saveMovieDetails() async {
    if (pickedImage.value != null) {
      Map<String, dynamic> movie = {
        'movieName': nameController.text,
        'movieGenre': genreController.text,
        'note': noteController.text,
        'img': await File(pickedImage.value!.path).readAsBytes(),
      };

      await db.insertMovieWithImage(pickedImage.value!.path, movie);
      hasUpload.value = false;
      pickedImage.value = null;

      await fetchResults();
    } else {
      print("No image selected to save with the movie details.");
    }
  }

  Future<void> deleteMovie(int id) async {
    await db.deleteMovie(id);
    await fetchResults();
  }

  Future<void> fetchResults() async {
    try {
      final fetchedResults = await db.getAllMovies();
      results.assignAll(fetchedResults);
    } catch (e) {
      print("Error fetching results: $e");
    }
  }
  void SharePresed(){
    String m='Check out my movie i have added to Movie I Trust App';
    Share.share(m);
  }
  Future<void>completeIntro () async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Get.off(()=>HomeScreen());
  }
}
