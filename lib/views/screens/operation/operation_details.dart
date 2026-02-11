import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/models/operationT.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class OperationDetails extends StatelessWidget {
  const OperationDetails({super.key, required this.operationT});
  final OperationT operationT;

  Color _typeColor(ThemeData theme) {
    if (operationT.type == 'وارد') {
      return AppColors.success;
    }
    if (operationT.type == 'صرف') {
      return AppColors.error;
    }
    return theme.colorScheme.primary;
  }

  Widget _chip({required IconData icon, required String text, Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: (color ?? AppColors.primary).withOpacity(0.10),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: (color ?? AppColors.primary).withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: color ?? AppColors.primary),
          SizedBox(width: 6.w),
          Text(
            text,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: AppColors.textOnBackground,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.start,
              style: Get.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textOnBackground,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            label,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: themeGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color get themeGrey => Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<OpController>(
      init: Get.find<OpController>(),
      builder: (opPro) {
        final typeColor = _typeColor(theme);
        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBar(
            centerTitle: true,
            elevation: 3,
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.textOnBackground,
            title: Text(
              'تفاصيل العملية',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.15),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 46.r,
                                width: 46.r,
                                decoration: BoxDecoration(
                                  color: typeColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Icon(
                                  operationT.type == 'وارد'
                                      ? Icons.arrow_downward_rounded
                                      : Icons.arrow_upward_rounded,
                                  color: typeColor,
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      operationT.type ?? 'العملية',
                                      style:
                                          theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textOnBackground,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      operationT.formattedDate ?? '',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: themeGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: typeColor,
                                  borderRadius: BorderRadius.circular(999.r),
                                ),
                                child: Text(
                                  '${operationT.amount ?? ''} لتر',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: [
                              _chip(
                                icon: Icons.local_gas_station_rounded,
                                text: operationT.foulType ?? '',
                                color: AppColors.accent,
                              ),
                              if (operationT.dischangeNumber != null &&
                                  operationT.dischangeNumber != '_')
                                _chip(
                                  icon: Icons.receipt_long_rounded,
                                  text: '${operationT.dischangeNumber}',
                                  color: AppColors.warning,
                                ),
                              if (operationT.receiverName != null &&
                                  operationT.receiverName != '_')
                                _chip(
                                  icon: Icons.person_rounded,
                                  text: '${operationT.receiverName}',
                                  color: AppColors.primary,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.draw_rounded,
                                  color: AppColors.primary, size: 20.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'التفاصيل',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            color: AppColors.primary.withOpacity(0.12),
                            height: 18.h,
                          ),
                          if (operationT.consumerName != null &&
                              operationT.consumerName != '_')
                            _detailRow(
                              label: 'المستهلك الأساسي',
                              value: operationT.consumerName ?? '',
                            ),
                          if (operationT.subConsumerDetails != null &&
                              operationT.subConsumerDetails != '_')
                            _detailRow(
                              label: 'المستهلك الفرعي',
                              value: operationT.subConsumerDetails ?? '',
                            ),
                          if (operationT.description != null &&
                              (operationT.description ?? '').isNotEmpty)
                            _detailRow(
                              label: 'الوصف',
                              value: operationT.description ?? '',
                            ),
                          if (!((operationT.consumerName != null &&
                                  operationT.consumerName != '_') ||
                              (operationT.subConsumerDetails != null &&
                                  operationT.subConsumerDetails != '_') ||
                              (operationT.description != null &&
                                  (operationT.description ?? '').isNotEmpty)))
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Text(
                                'لا توجد تفاصيل إضافية لهذه العملية.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: themeGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'حذف',
                                backgroundColor: theme.colorScheme.surface,
                                content: Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 100.h,
                                          width: 200.h,
                                          child: Lottie.asset(
                                              'assets/warning.json')),
                                      SizedBox(height: 5.h),
                                      Text('هل متاكد من حذف العنصر؟',
                                          style: theme.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                confirm: GetBuilder<SubController>(
                                    init: Get.find<SubController>(),
                                    builder: (subPro) {
                                      return InkWell(
                                        onTap: () {
                                          opPro.deleteOperation(operationT.id!);
                                          subPro.getAllSubOp(operationT.id!);
                                          opPro.getAllOpT();
                                          Get.back();
                                          Get.back();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          padding: EdgeInsets.all(10.w),
                                          child: Text('نعم',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white)),
                                        ),
                                      );
                                    }),
                                cancel: InkWell(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    padding: EdgeInsets.all(10.w),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Text('لا',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.white)),
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: AppColors.error.withOpacity(0.40),
                                  width: 1.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              foregroundColor: AppColors.error,
                              backgroundColor:
                                  AppColors.error.withOpacity(0.06),
                            ),
                            icon: Icon(Icons.delete, size: 18.sp),
                            label: Text(
                              'حذف',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              opPro.checkOperationType(operationT);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.textOnPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              elevation: 0,
                            ),
                            icon: Icon(Icons.edit, size: 18.sp),
                            label: Text(
                              'تعديل',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.textOnPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
