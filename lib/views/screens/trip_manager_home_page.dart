import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/trip_controller.dart';
import 'package:fuel_management_app/Controllers/login_controller.dart';
import 'package:fuel_management_app/views/screens/trips/add_trip.dart';
import 'package:fuel_management_app/views/screens/trips/show_trips.dart';
import 'package:get/get.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class TripManagerHomePage extends StatelessWidget {
  const TripManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SideMenuController sideMenuController = SideMenuController();
    final loginController = Get.find<LoginController>();

    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Container(
                width: 220.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.sideMenuDark,
                      AppColors.sideMenuDark.withOpacity(0.95),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 32,
                      offset: const Offset(-8, 0),
                    ),
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 16,
                      offset: const Offset(-4, 0),
                    ),
                  ],
                  border: Border(
                    right: BorderSide(
                      color: AppColors.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SideMenu(
                    controller: sideMenuController,
                    style: SideMenuStyle(
                      selectedIconColorExpandable: AppColors.accentLight,
                      unselectedIconColorExpandable: AppColors.accentLight,
                      backgroundColor: Colors.transparent,
                      selectedColor: AppColors.accent.withOpacity(0.15),
                      selectedTitleTextStyle: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        letterSpacing: 0.3,
                      ),
                      unselectedTitleTextStyle: TextStyle(
                        color: AppColors.textOnPrimary.withOpacity(0.85),
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        letterSpacing: 0.2,
                      ),
                      arrowCollapse: Colors.grey,
                      arrowOpen: Colors.white,
                      selectedIconColor: AppColors.accent,
                      unselectedIconColor:
                          AppColors.textOnPrimary.withOpacity(0.7),
                      openSideMenuWidth: 220.w,
                      compactSideMenuWidth: 60.w,
                      showHamburger: false,
                      itemBorderRadius: BorderRadius.circular(12.r),
                      itemHeight: 48.h,
                      itemInnerSpacing: 12.w,
                      itemOuterPadding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      iconSize: 22.sp,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 24.h,
                        horizontal: 16.w,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.accent,
                                        AppColors.accent.withOpacity(0.8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(
                                    Icons.emoji_transportation_rounded,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'مدير الرحلات',
                                      style: TextStyle(
                                        color: AppColors.textOnPrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      'إدارة الرحلات',
                                      style: TextStyle(
                                        color: AppColors.textOnPrimary
                                            .withOpacity(0.7),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'نظام إدارة المحروقات',
                            style: TextStyle(
                              color: AppColors.textOnPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    footer: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppColors.textOnPrimary.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    items: [
                      SideMenuItem(
                        title: 'لوحة التحكم',
                        icon: const Icon(Icons.dashboard_rounded),
                        onTap: (index, _) {},
                      ),
                      SideMenuExpansionItem(
                        title: 'الرحلات',
                        icon: const Icon(Icons.emoji_flags_rounded),
                        children: [
                          SideMenuItem(
                            title: 'عرض الرحلات',
                            icon: const Icon(Icons.visibility_rounded),
                            onTap: (index, _) {
                              Get.find<TripController>().getTrips();
                              Get.to(const ShowTrips());
                            },
                          ),
                          SideMenuItem(
                            title: 'إضافة رحلة',
                            icon: const Icon(Icons.add_circle_rounded),
                            onTap: (index, _) {
                              final pro = Get.find<TripController>();
                              pro.clearFields();
                              pro.getConusmersNames();
                              Get.to(const AddTrip());
                            },
                          ),
                        ],
                      ),
                      SideMenuItem(
                        title: 'تسجيل الخروج',
                        icon: const Icon(Icons.logout_rounded),
                        onTap: (index, _) {
                          loginController.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Expanded(
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: 20.w,
                                left: 20.w,
                                bottom: 3.h,
                                top: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'مرحباً مدير الرحلات 👋',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textOnBackground,
                                            fontSize: 18.sp,
                                          ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'نظام إدارة المحروقات - إدارة الرحلات',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textOnBackground,
                                            fontSize: 22.sp,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 18.w),
                                CircleAvatar(
                                  radius: 32.r,
                                  backgroundColor: AppColors.accentLight,
                                  child: Icon(Icons.emoji_transportation,
                                      color: AppColors.accentDark, size: 36.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_flags_rounded,
                                  size: 80.sp,
                                  color: AppColors.primary.withOpacity(0.5),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'إدارة الرحلات',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textOnBackground,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'استخدم القائمة الجانبية لعرض وإضافة الرحلات',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.textOnBackground
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
