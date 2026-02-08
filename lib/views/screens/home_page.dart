import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/controllers/db_controller.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/controllers/trip_controller.dart';
import 'package:fuel_management_app/views/screens/consumer/add.dart';
import 'package:fuel_management_app/views/screens/subconsumer/add_subconsumer.dart';
import 'package:fuel_management_app/views/screens/trips/add_trip.dart';
import 'package:fuel_management_app/views/screens/operation/close_month.dart';
import 'package:fuel_management_app/views/screens/operation/search_operation.dart';
import 'package:fuel_management_app/views/screens/consumer/show_consumers.dart';
import 'package:fuel_management_app/views/screens/operation/show_available_fuel.dart';
import 'package:fuel_management_app/views/screens/operation/show_operation.dart';
import 'package:fuel_management_app/views/screens/operation/show_subOperation.dart';
import 'package:fuel_management_app/views/screens/subconsumer/show_subconsumer.dart';
import 'package:fuel_management_app/views/screens/trips/show_trips.dart';
import 'package:fuel_management_app/views/screens/operation/add_operation_sarf.dart';
import 'package:fuel_management_app/views/screens/operation/add_operation_estrad.dart';
import 'package:get/get.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import '../Widgets/home_page_card.dart';
import '../Widgets/operationTable.dart';
import '../../core/constant/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SideMenuController sideMenuController = SideMenuController();
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              // Modern Professional SideMenu
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
                                    Icons.person_rounded,
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
                                      'المدير',
                                      style: TextStyle(
                                        color: AppColors.textOnPrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      'مدير النظام',
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

                          // Modern Logo Container
                          // Container(
                          //   width: 30.w,
                          //   height: 30.h,
                          //   decoration: BoxDecoration(
                          //     gradient: LinearGradient(
                          //       begin: Alignment.topLeft,
                          //       end: Alignment.bottomRight,
                          //       colors: [
                          //         AppColors.accent,
                          //         AppColors.accent.withOpacity(0.8),
                          //       ],
                          //     ),
                          //     borderRadius: BorderRadius.circular(20.r),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: AppColors.accent.withOpacity(0.3),
                          //         blurRadius: 16,
                          //         offset: const Offset(0, 8),
                          //       ),
                          //     ],
                          //   ),
                          //   child: Icon(
                          //     Icons.local_gas_station_rounded,
                          //     color: Colors.white,
                          //     size: 30.sp,
                          //   ),
                          // ),

                          SizedBox(height: 20.h),
                          // App Title
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
                          // SizedBox(height: 4.h),
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
                          SizedBox(height: 16.h),
                          // User Profile Section
                        ],
                      ),
                    ),
                    items: [
                      // Main Dashboard
                      SideMenuItem(
                        title: 'لوحة التحكم',
                        icon: const Icon(Icons.dashboard_rounded),
                        onTap: (index, _) {},
                      ),
                      // Divider

                      // Main Consumers
                      SideMenuExpansionItem(
                        title: 'المستهلكين الرئيسين',
                        icon: const Icon(Icons.people_alt_rounded),
                        children: [
                          SideMenuItem(
                            title: 'عرض المستهلكين',
                            icon: const Icon(Icons.visibility_rounded),
                            onTap: (index, _) {
                              Get.to(const ShowConsumers());
                              Get.find<DbController>().getConsumerForTable();
                            },
                          ),
                          SideMenuItem(
                            title: 'إضافة مستهلك',
                            icon: const Icon(Icons.person_add_rounded),
                            onTap: (index, _) {
                              Get.to(const Add());
                            },
                          ),
                        ],
                      ),
                      // Sub Consumers
                      SideMenuExpansionItem(
                        title: 'المستهلكين الفرعين',
                        icon: const Icon(Icons.group_rounded),
                        children: [
                          SideMenuItem(
                            title: 'عرض المستهلكين',
                            icon: const Icon(Icons.visibility_rounded),
                            onTap: (index, _) {
                              Get.find<SubController>().getSubConsumerT();
                              Get.to(const ShowSubconsumer());
                            },
                          ),
                          SideMenuItem(
                            title: 'إضافة مستهلك',
                            icon: const Icon(Icons.person_add_rounded),
                            onTap: (index, _) {
                              final controller = Get.find<SubController>();
                              controller.clearFields();
                              controller.getConsumersNames();
                              Get.to(const AddSubconsumer());
                            },
                          ),
                        ],
                      ),
                      // Operations
                      SideMenuExpansionItem(
                        title: 'العمليات',
                        icon: const Icon(Icons.settings_rounded),
                        children: [
                          SideMenuItem(
                            title: 'عرض العمليات',
                            icon: const Icon(Icons.visibility_rounded),
                            onTap: (index, _) {
                              Get.find<OpController>().getAllOpT();
                              Get.to(const ShowOperation());
                            },
                          ),
                          SideMenuItem(
                            title: ' إضافة عملية صرف',
                            icon: const Icon(Icons.arrow_upward),
                            onTap: (index, _) {
                              final controller = Get.find<OpController>();
                              controller.clearWardFeild();
                              controller.getConsumersNames();
                              Get.to(const AddSarf());
                            },
                          ),
                          SideMenuItem(
                            title: 'إضافة عملية استرداد',
                            icon: const Icon(Icons.arrow_downward),
                            onTap: (index, _) {
                              final opPro = Get.find<OpController>();
                              opPro.clearWardFeild();
                              Get.to(const AddOperationEstrad());
                            },
                          ),
                        ],
                      ),
                      // Trips
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
                      // Divider

                      // Search
                      SideMenuItem(
                        title: 'البحث',
                        icon: const Icon(Icons.search_rounded),
                        onTap: (index, _) {
                          final controller = Get.find<OpController>();
                          controller.getConsumersNames();
                          controller.clearSarfFeild();
                          controller.clearWardFeild();
                          Get.to(const SearchOperation());
                        },
                      ),
                      // Close Month
                      SideMenuItem(
                        title: 'إغلاق الشهر',
                        icon: const Icon(Icons.book_rounded),
                        onTap: (index, _) {
                          final controller = Get.find<OpController>();
                          controller.month = null;
                          controller.year = null;
                          controller.getMonthsAndYears();
                          controller.getOperationOfDate();
                          Get.to(const CloseMonth());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Main content
              Directionality(
                textDirection: TextDirection.ltr,
                child: Expanded(
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // User greeting section
                          Padding(
                            padding: EdgeInsets.only(
                                right: 20.w, left: 20.w, bottom: 3.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'مرحباً 👋',
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
                                      'نظام إدارة المحروقات',
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
                                  child: Icon(Icons.person,
                                      color: AppColors.accentDark, size: 36.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 18.h),
                          // Summary cards area with shadow
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                // No shadow
                              ),
                              child: GridView.count(
                                crossAxisCount: MediaQuery.of(context)
                                            .size
                                            .width >
                                        1200
                                    ? 5
                                    : MediaQuery.of(context).size.width > 900
                                        ? 4
                                        : MediaQuery.of(context).size.width >
                                                600
                                            ? 3
                                            : 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 20.w,
                                crossAxisSpacing: 20.w,
                                childAspectRatio: 0.95,
                                children: [
                                  HomePageCard(
                                    onPress: () {
                                      Get.find<OpController>()
                                          .getFuelAvailable();
                                      Get.to(const ShowAvailableFuel());
                                    },
                                    backgroundColor: AppColors.warning,
                                    icon: Icons.window,
                                    mainText:
                                        '${Get.find<OpController>().totalAvailable}',
                                    unitText: ' (لتر)  ',
                                    subText: 'إجمالي المتوفر',
                                    textColor: AppColors.textOnBackground,
                                    iconColor: AppColors.warningDark,
                                  ),
                                  HomePageCard(
                                    onPress: () {
                                      Get.find<OpController>()
                                          .setSubTitle('عمليات الوارد ');
                                      Get.find<OpController>()
                                          .getTotalSubOP('وارد');
                                      Get.to(const ShowOperation());
                                    },
                                    backgroundColor: AppColors.accent,
                                    icon: Icons.arrow_downward_outlined,
                                    mainText:
                                        '${Get.find<OpController>().totalWard}',
                                    unitText: ' (لتر)  ',
                                    subText: 'إجمالي الوارد',
                                    textColor: AppColors.textOnPrimary,
                                    iconColor: AppColors.accentDark,
                                  ),
                                  GetBuilder<OpController>(
                                    init: Get.find<OpController>(),
                                    builder: (opController) {
                                      return HomePageCard(
                                        onPress: () {
                                          opController.setSubTitle(
                                              'عمليات الوارد الشهري');
                                          opController.getMonthlySubOP('وارد');
                                          Get.to(const ShowOperation());
                                        },
                                        backgroundColor: AppColors.success,
                                        icon: Icons.arrow_downward_outlined,
                                        mainText: '${opController.monthlyWard}',
                                        unitText: ' (لتر)  ',
                                        subText: 'الوارد الشهري',
                                        textColor: AppColors.textOnPrimary,
                                        iconColor: AppColors.successDark,
                                      );
                                    },
                                  ),
                                  GetBuilder<DbController>(
                                      init: Get.find<DbController>(),
                                      builder: (dbController) {
                                        return HomePageCard(
                                          onPress: () =>
                                              Get.to(const ShowSubconsumer()),
                                          backgroundColor: AppColors.error,
                                          icon: Icons.people_rounded,
                                          mainText: '${dbController.numOfSub}',
                                          unitText: ' (مستهلك)  ',
                                          subText: 'عدد المستهلكين',
                                          textColor: AppColors.textOnPrimary,
                                          iconColor: AppColors.errorDark,
                                        );
                                      }),
                                  // Fifth card example
                                  HomePageCard(
                                    onPress: () {},
                                    backgroundColor: AppColors.primary,
                                    icon: Icons.info_outline,
                                    mainText: '123',
                                    unitText: '',
                                    subText: 'بطاقة إضافية',
                                    textColor: AppColors.textOnPrimary,
                                    iconColor: AppColors.primaryDark,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          // Section divider
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
                              children: [
                                const Expanded(child: Divider(thickness: 1.2)),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Text(
                                    'آخر العمليات',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.accentDark,
                                          fontSize: 16.sp,
                                        ),
                                  ),
                                ),
                                const Expanded(child: Divider(thickness: 1.2)),
                              ],
                            ),
                          ),
                          // SizedBox(height: 5.h),
                          // Operations table in a modern card
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: GetBuilder<OpController>(
                              init: Get.find<OpController>(),
                              builder: (controller) {
                                return OperationTable(
                                  operations: controller.lastTenOp ?? [],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 5.h),
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
