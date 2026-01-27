import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:fuel_management_app/controllers/db_controller.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class UpdateConsumer extends StatelessWidget {
  const UpdateConsumer({super.key});

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
          'تعديل مستهلك',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Card(
              elevation: 8,
              color: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: GetBuilder<DbController>(
                init: Get.find<DbController>(),
                builder: (db) {
                  return Form(
                    key: db.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            'تعديل مستهلك',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.textOnPrimary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 16.h),
                          child: MyTextFormField(
                            validator: db.nameValidtor,
                            controller: db.consumerNameController,
                            labelText: 'اسم المستهلك',
                            hintText: 'أدخل اسم المستهلك',
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: MyButton(
                            text: 'تعديل',
                            onTap: db.onTopUpdate,
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
