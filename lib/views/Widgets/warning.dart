import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/views/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant/app_colors.dart';

class Warning {
  static noAvalbile() {
    Get.defaultDialog(
        title: 'حذف',
        backgroundColor: AppColors.background,
        content: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              SizedBox(
                  height: 100.h,
                  width: 200.h,
                  child: Lottie.asset('assets/warning.json')),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'لا يوجد وقود لصرفه',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        cancel: ElevatedButton(
          onPressed: () => Get.to(const HomePage()),
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.delete,
              foregroundColor: AppColors.buttonText),
          child: const Text('اغلاق'),
        ));
  }
}
