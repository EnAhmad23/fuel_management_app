import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/models/movement.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:fuel_management_app/controllers/sub_controller.dart';
import '../../core/constant/app_colors.dart';

class MovementTable extends StatelessWidget {
  final List<Movement> movements;
  const MovementTable({super.key, required this.movements});

  @override
  Widget build(BuildContext context) {
    log('operations $movements');

    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isLargeDesktop = screenWidth >= 1440;

    if (movements.isEmpty) {
      return Center(
        child: Container(
          height: 300.h,
          width: isMobile ? 300.w : (isTablet ? 400.w : 600.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: isMobile ? 80.h : 120.h,
                width: isMobile ? 80.w : 120.w,
                child: Lottie.asset('assets/json/nodata.json'),
              ),
              SizedBox(height: 16.h),
              Text(
                'لا توجد حركات لعرضها',
                style: TextStyle(
                  fontSize: isMobile ? 14.sp : 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textOnBackground,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // For mobile devices, show a card-based layout instead of table
    if (isMobile) {
      return _buildMobileLayout();
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.resolveWith(
              (states) => AppColors.primary.withOpacity(0.06),
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
            ),
            border: TableBorder.symmetric(
              inside: BorderSide(
                color: AppColors.primary.withOpacity(0.08),
                width: 0.5,
              ),
              outside: BorderSide(
                color: AppColors.primary.withOpacity(0.12),
                width: 1,
              ),
            ),
            headingRowHeight: isTablet ? 64.h : (isDesktop ? 60.h : 56.h),
            dataRowHeight: isTablet ? 72.h : (isDesktop ? 68.h : 64.h),
            columnSpacing: isLargeDesktop ? 24.w : (isDesktop ? 20.w : 16.w),
            columns: _buildTableColumns(
                isMobile, isTablet, isDesktop, isLargeDesktop),
            rows: _buildTableRows(
                movements, isMobile, isTablet, isDesktop, isLargeDesktop),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movements.length,
      itemBuilder: (context, index) {
        final movement = movements[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '#${index + 1}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                    _buildMobileActions(movement),
                  ],
                ),
                SizedBox(height: 12.h),

                // Data rows
                _buildMobileDataRow('التاريخ', '${movement.formattedDate}'),
                _buildMobileDataRow('قراءة العداد', '${movement.record}'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileDataRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textOnBackground.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textOnBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileActions(Movement movement) {
    return GetBuilder<SubController>(
      init: Get.find<SubController>(),
      builder: (subPro) {
        return _buildMobileActionButton(
          icon: Icons.delete,
          color: AppColors.errorDark,
          onTap: () => _showDeleteDialog(movement, subPro),
        );
      },
    );
  }

  Widget _buildMobileActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Icon(
            icon,
            size: 18.sp,
            color: color,
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns(
      bool isMobile, bool isTablet, bool isDesktop, bool isLargeDesktop) {
    return [
      DataColumn(
        label: _buildColumnHeader('الإعدادات', isMobile, isTablet, isDesktop,
            width: isTablet ? 70.w : (isDesktop ? 80.w : 90.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('التاريخ', isMobile, isTablet, isDesktop,
            width: isTablet ? 60.w : (isDesktop ? 70.w : 80.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('قراءة العداد', isMobile, isTablet, isDesktop,
            width: isTablet ? 70.w : (isDesktop ? 80.w : 90.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('#', isMobile, isTablet, isDesktop,
            width: isTablet ? 30.w : (isDesktop ? 35.w : 40.w)),
      ),
    ];
  }

  Widget _buildColumnHeader(
      String text, bool isMobile, bool isTablet, bool isDesktop,
      {double? width}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
            fontWeight: FontWeight.w700,
            color: AppColors.textOnBackground,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows(List<Movement> movements, bool isMobile,
      bool isTablet, bool isDesktop, bool isLargeDesktop) {
    return movements.map((movement) {
      final isStriped = movements.indexOf(movement) % 2 == 1;

      return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary.withOpacity(0.04);
          }
          return isStriped ? AppColors.surface : Colors.white;
        }),
        cells: [
          _buildSettingsCell(
              movement, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildDateCell(
              movement, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildRecordCell(
              movement, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildIndexCell(movements.indexOf(movement), isMobile, isTablet,
              isDesktop, isLargeDesktop),
        ],
      );
    }).toList();
  }

  DataCell _buildSettingsCell(Movement movement, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Padding(
        padding: EdgeInsets.symmetric(vertical: isTablet ? 12.h : 16.h),
        child: GetBuilder<SubController>(
          init: Get.find<SubController>(),
          builder: (subPro) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionButton(
                  icon: Icons.delete,
                  color: AppColors.errorDark,
                  onTap: () => _showDeleteDialog(movement, subPro),
                  isMobile: isMobile,
                  isTablet: isTablet,
                  isDesktop: isDesktop,
                  isLargeDesktop: isLargeDesktop,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isMobile,
    required bool isTablet,
    required bool isDesktop,
    required bool isLargeDesktop,
  }) {
    final size = isTablet ? 24.w : (isDesktop ? 28.w : 32.w);
    final iconSize = isTablet ? 12.sp : (isDesktop ? 14.sp : 16.sp);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6.r),
          child: Icon(
            icon,
            size: iconSize,
            color: color,
          ),
        ),
      ),
    );
  }

  DataCell _buildDateCell(Movement movement, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            '${movement.formattedDate}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
              color: AppColors.textOnBackground,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  DataCell _buildRecordCell(Movement movement, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border:
                Border.all(color: AppColors.accent.withOpacity(0.2), width: 1),
          ),
          child: Text(
            '${movement.record}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
              color: AppColors.accentDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  DataCell _buildIndexCell(int index, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: Container(
          width: isTablet ? 20.w : (isDesktop ? 24.w : 28.w),
          height: isTablet ? 20.h : (isDesktop ? 24.h : 28.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: isTablet ? 8.sp : (isDesktop ? 9.sp : 10.sp),
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(Movement movement, SubController subPro) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    final isMobile = screenWidth < 768;

    Get.defaultDialog(
      title: '',
      backgroundColor: Colors.white,
      barrierDismissible: true,
      content: Container(
        padding: EdgeInsets.all(isMobile ? 20.w : 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: isMobile ? 80.h : 100.h,
              width: isMobile ? 80.w : 100.w,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                size: isMobile ? 40.sp : 50.sp,
                color: AppColors.errorDark,
              ),
            ),
            SizedBox(height: isMobile ? 16.h : 20.h),
            Text(
              'هل أنت متأكد من حذف هذه الحركة؟',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textOnBackground,
                fontSize: isMobile ? 16.sp : 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: isMobile ? 8.h : 12.h),
            Text(
              'لا يمكن التراجع عن هذا الإجراء',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textOnBackground.withOpacity(0.7),
                fontSize: isMobile ? 14.sp : 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: isMobile ? 24.h : 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildDialogButton(
                    text: 'إلغاء',
                    color: AppColors.success,
                    onTap: () => Get.back(),
                    isMobile: isMobile,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildDialogButton(
                    text: 'حذف',
                    color: AppColors.error,
                    onTap: () {
                      subPro.deleteMovement(movement.id, movement.subId ?? 0);
                      Get.back();
                    },
                    isMobile: isMobile,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
    required bool isMobile,
  }) {
    return Container(
      height: isMobile ? 44.h : 48.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 14.sp : 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
