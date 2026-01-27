import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  // ignore: overridden_fields
  // ignore: overridden_fields
  const CustomSnackBar();

  GetSnackBar showSnackBar({
    required String title,
    required String message,
    String? lottieAssetPath,
    Color? backgroundColor,
    Color? titleColor,
    Color? messageColor,
  }) {
    // Set defaults if not provided
    final String assetPath = lottieAssetPath ?? 'assets/json/check.json';
    final Color bgColor = backgroundColor ?? Colors.white;
    final Color titleTextColor = titleColor ?? Colors.black;
    final Color messageTextColor = messageColor ?? Colors.black;

    return GetSnackBar(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: titleTextColor,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 20.sp,
          color: messageTextColor,
        ),
      ),
      maxWidth: 600.w,
      icon: SizedBox(
        height: 40.h,
        width: 40.h,
        child: Lottie.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
      backgroundColor: bgColor,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10.r,
      margin: EdgeInsets.all(16.w),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'إغلاق',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
