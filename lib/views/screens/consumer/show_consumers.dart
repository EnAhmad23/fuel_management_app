import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/views/Widgets/consumers_table.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/Controllers/db_controller.dart';
import 'package:fuel_management_app/models/consumer.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class ShowConsumers extends StatelessWidget {
  const ShowConsumers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textOnBackground,
        title: Text(
          'المستهلكين الرئيسيين',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.surface, AppColors.background],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.surface, AppColors.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              _buildHeaderCard(),
              SizedBox(height: 24.h),
              _buildConsumersTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    final theme = Get.theme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.groups_rounded,
            size: 24.sp,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(width: 12.w),
          Text(
            'جدول المستهلكين الرئيسيين',
            style: Get.textTheme.titleMedium?.copyWith(
              color: AppColors.textOnPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConsumersTable() {
    return GetBuilder<DbController>(
      init: Get.find<DbController>(),
      builder: (dbProvider) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(
              color: AppColors.primary.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
          elevation: 6,
          shadowColor: Colors.black.withValues(alpha: 0.06),
          child: SingleChildScrollView(
            child: ConsumersTable(
              consumers: dbProvider.consumers ??
                  [
                    AppConsumers(
                      name: 'name',
                      subConsumerCount: -1,
                      operationsCount: -1,
                      id: -1,
                    ),
                  ],
            ),
          ),
        );
      },
    );
  }
}
