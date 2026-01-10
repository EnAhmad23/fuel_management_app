import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/trip_controller.dart';
import 'package:fuel_management_app/views/Widgets/trip_table.dart';

class ShowTrips extends StatelessWidget {
  const ShowTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'الرحلات',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary, fontSize: 24.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: TripTable(trips: Get.find<TripController>().trips ?? []),
          ),
        ),
      ),
    );
  }
}
