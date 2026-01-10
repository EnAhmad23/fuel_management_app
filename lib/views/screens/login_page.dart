import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/login_controller.dart';
import '../Widgets/myTextFormField.dart';
import '../../core/constant/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.icon.withOpacity(0.08),
                      blurRadius: 32.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 60.sp,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                width: 400.w,
                padding: EdgeInsets.all(24.w),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  color: theme.colorScheme.surface,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: GetBuilder<LoginController>(
                      init: Get.find<LoginController>(),
                      builder: (loginProvider) {
                        return Form(
                          key: loginProvider.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'تسجيل الدخول',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 32.h),
                              MyTextFormField(
                                labelText: 'إسم المستخدم',
                                hintText: 'ادخل إسم المستخدم',
                                controller: loginProvider.userName,
                                validator: loginProvider.validUsername,
                              ),
                              SizedBox(height: 20.h),
                              MyTextFormField(
                                labelText: 'كلمة المرور',
                                obscureText: true,
                                hintText: 'أدخل كلمة المرور',
                                controller: loginProvider.password,
                                validator: loginProvider.validatePassword,
                              ),
                              SizedBox(height: 32.h),
                              SizedBox(
                                height: 48.h,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.buttonText,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      elevation: 4,
                                    ),
                                    onPressed: () => loginProvider.login(),
                                    child: Text(
                                      'تسجيل الدخول',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        color: AppColors.buttonText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              // Optionally, add a forgot password or help link here
                            ],
                          ),
                        );
                      },
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
