import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/controllers/db_controller.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:get/get.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      title: Text(
        'إنشاء مستهلك',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textOnPrimary,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 20.sp,
          color: AppColors.textOnPrimary,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 30.h),
            _buildFormCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_add_rounded,
            size: 48.sp,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(height: 12.h),
          Text(
            'إضافة مستهلك جديد',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textOnPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'قم بإدخال بيانات المستهلك الجديد',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textOnPrimary.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: GetBuilder<DbController>(
        init: Get.find<DbController>(),
        builder: (db) {
          return Form(
            key: db.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFormField(db),
                SizedBox(height: 32.h),
                _buildSubmitButton(db),
                SizedBox(height: 16.h),
                _buildCancelButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormField(DbController db) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اسم المستهلك',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        MyTextFormField(
          validator: db.nameValidtor,
          controller: db.consumerNameController,
          labelText: 'اسم المستهلك',
          hintText: 'أدخل اسم المستهلك هنا',
        ),
      ],
    );
  }

  Widget _buildSubmitButton(DbController db) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            // Add haptic feedback
            HapticFeedback.lightImpact();
            db.opTap();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.save_rounded,
                  size: 20.sp,
                  color: AppColors.textOnPrimary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'إنشاء المستهلك',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            HapticFeedback.lightImpact();
            Get.back();
          },
          child: Center(
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
