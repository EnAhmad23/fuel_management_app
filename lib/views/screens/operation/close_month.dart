import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/Controllers/op_controller.dart';
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
        child: GetBuilder<OpController>(
          init: Get.find<OpController>(),
          builder: (controller) {
            final inputDecoration = InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.6),
              ),
            );

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1100.w),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          color: AppColors.background,
                          elevation: 10,
                          shadowColor: AppColors.primary.withOpacity(0.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 42.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.primary.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: const Icon(
                                        Icons.date_range_rounded,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        'اختيار الشهر والسنة',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textOnBackground,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: controller.month,
                                        decoration: inputDecoration.copyWith(
                                          labelText: 'الشهر',
                                        ),
                                        items: (controller.months ?? [])
                                            .map(
                                              (m) => DropdownMenuItem<String>(
                                                value: m,
                                                child: Text(m),
                                              ),
                                            )
                                            .toList(),
                                        validator: controller.monthValidet,
                                        onChanged: (v) {
                                          controller.month = v;
                                          controller.getOperationOfDate();
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: controller.year,
                                        decoration: inputDecoration.copyWith(
                                          labelText: 'السنة',
                                        ),
                                        items: (controller.years ?? {})
                                            .map(
                                              (y) => DropdownMenuItem<String>(
                                                value: y,
                                                child: Text(y),
                                              ),
                                            )
                                            .toList(),
                                        validator: controller.yearValidet,
                                        onChanged: (v) {
                                          controller.year = v;
                                          controller.getOperationOfDate();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Card(
                          color: AppColors.background,
                          elevation: 10,
                          shadowColor: AppColors.primary.withOpacity(0.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 42.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.accent.withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: const Icon(
                                        Icons.table_chart_rounded,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        'عمليات الشهر المحدد',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textOnBackground,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                CloseTable(
                                  operations: controller.operations ?? [],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Card(
                          color: AppColors.background,
                          elevation: 10,
                          shadowColor: AppColors.error.withOpacity(0.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18.w),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.error,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              onPressed: controller.onTapClose,
                              icon: const Icon(Icons.lock_outline_rounded),
                              label: Text(
                                'إغلاق الشهر',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
