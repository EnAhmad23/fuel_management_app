import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/Controllers/login_controller.dart';
import '../Widgets/myTextFormField.dart';
import '../../core/constant/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.accentLight,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 440.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.14),
                            AppColors.accent.withOpacity(0.10),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 28.r,
                            offset: Offset(0, 10.h),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 44.r,
                        backgroundColor: AppColors.primary.withOpacity(0.10),
                        child: Icon(
                          Icons.local_gas_station_rounded,
                          color: AppColors.primary,
                          size: 46.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      'نظام إدارة المحروقات',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 22.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'سجّل الدخول للمتابعة إلى لوحة التحكم',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textOnBackground.withOpacity(0.65),
                        fontSize: 13.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 18.h),
                    Card(
                      elevation: 10,
                      shadowColor: AppColors.cardShadow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      color: AppColors.surface,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 22.h),
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
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20.h),
                                  MyTextFormField(
                                    labelText: 'إسم المستخدم',
                                    hintText: 'ادخل إسم المستخدم',
                                    controller: loginProvider.userName,
                                    validator: loginProvider.validUsername,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 16.h),
                                  MyTextFormField(
                                    labelText: 'كلمة المرور',
                                    obscureText: true,
                                    hintText: 'أدخل كلمة المرور',
                                    controller: loginProvider.password,
                                    validator: loginProvider.validatePassword,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) =>
                                        loginProvider.login(),
                                  ),
                                  SizedBox(height: 22.h),
                                  SizedBox(
                                    height: 48.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.buttonText,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.r),
                                        ),
                                        elevation: 3,
                                      ),
                                      onPressed: loginProvider.isLoading
                                          ? null
                                          : () => loginProvider.login(),
                                      child: loginProvider.isLoading
                                          ? SizedBox(
                                              width: 22.w,
                                              height: 22.h,
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 3,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  AppColors.buttonText,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              'تسجيل الدخول',
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                color: AppColors.buttonText,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
