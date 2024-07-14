import 'package:flutter/cupertino.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../controller/controller.dart';

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
  ).show();
}