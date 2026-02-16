import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/Controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/operationTable.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

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
          'نتائج البحث',
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
                        GetBuilder<OpController>(
                          init: Get.find<OpController>(),
                          builder: (pro) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 24.w,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: (pro.operations ?? []).isEmpty
                                      ? null
                                      : () {
                                          pro.generatePdf(
                                              context, pro.operations ?? []);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    alignment: Alignment.centerRight,
                                    foregroundColor: AppColors.textOnPrimary,
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 12.h,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'طباعة ',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: AppColors.textOnPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.print,
                                        color: AppColors.textOnPrimary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GetBuilder<OpController>(
                          init: Get.find<OpController>(),
                          builder: (opPro) {
                            final ops = opPro.operations ?? [];
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
                                child: ops.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 48.h,
                                          horizontal: 16.w,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'لا توجد عمليات في التاريخ المحدد',
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              color: AppColors.textOnBackground,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        child: OperationTable(
                                          operations: ops,
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
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
