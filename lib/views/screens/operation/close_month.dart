import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/close_table.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class CloseMonth extends StatelessWidget {
  const CloseMonth({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textOnBackground,
        title: Text(
          'إغلاق شهر',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Card(
              color: AppColors.background,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: CloseTable(
                  operations: Get.find<OpController>().operations ?? [],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
