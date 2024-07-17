import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/UI/home_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Warning {
  static noAvalbile() {
    Get.defaultDialog(
        title: 'حذف',
        backgroundColor: Colors.white,
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
              const Text(
                'لا يوجد وقود لصرفه',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        cancel: ElevatedButton(
          onPressed: () => Get.to(const HomePage()),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, foregroundColor: Colors.white),
          child: const Text('اغلاق'),
        ));
  }
}
