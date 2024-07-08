import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackbar {
  static doneSnack({required String massege}) {
    Get.snackbar(
      'تم',
      massege,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      isDismissible: true,
      duration: const Duration(seconds: 2),
    );
  }
}
