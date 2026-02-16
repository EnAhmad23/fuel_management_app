import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/Controllers/trip_controller.dart';
import 'package:fuel_management_app/views/Widgets/trip_table.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class ShowTrips extends StatelessWidget {
  const ShowTrips({super.key});

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
          'الرحلات',
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
                child: GetBuilder<TripController>(
                  init: Get.find<TripController>(),
                  builder: (tripController) {
                    return TripTable(
                      trips: tripController.trips ?? [],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
