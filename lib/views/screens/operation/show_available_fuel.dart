import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/fuel_amount_table.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class ShowAvailableFuel extends StatelessWidget {
  const ShowAvailableFuel({super.key});

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
          'إجمالي الوقود المتوفر',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Card(
                  elevation: 8,
                  color: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),
                          child: Text(
                            'جدول الوقود المتوفر',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.textOnPrimary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        GetBuilder<OpController>(
                          init: Get.find<OpController>(),
                          builder: (opPro) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(
                                    color: AppColors.primary.withOpacity(0.12),
                                  ),
                                ),
                                elevation: 4,
                                child: SingleChildScrollView(
                                  child: FuelAmountTable(
                                    fuelTypes: opPro.fuelavailable ?? [],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
