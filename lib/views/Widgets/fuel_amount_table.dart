import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../../models/fuel_available_amount.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import '../../core/constant/app_colors.dart';

class FuelAmountTable extends StatelessWidget {
  const FuelAmountTable({super.key, required this.fuelTypes});
  final List<FuelAvailableAmount> fuelTypes;

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isLargeDesktop = screenWidth >= 1440;

    if (fuelTypes.isEmpty) {
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
                child: Lottie.asset('assets/json/warning.json'),
              ),
              SizedBox(height: 16.h),
              Text(
                'لا توجد أنواع وقود لعرضها',
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
          child: GetBuilder<OpController>(
            init: Get.find<OpController>(),
            builder: (opPro) {
              return DataTable(
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
                columnSpacing:
                    isLargeDesktop ? 24.w : (isDesktop ? 20.w : 16.w),
                columns: _buildTableColumns(
                    isMobile, isTablet, isDesktop, isLargeDesktop),
                rows: _buildTableRows(
                    fuelTypes, isMobile, isTablet, isDesktop, isLargeDesktop),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: fuelTypes.length,
      itemBuilder: (context, index) {
        final fuelType = fuelTypes[index];
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
                // Header row with index
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
                SizedBox(height: 12.h),

                // Data rows
                _buildMobileDataRow('نوع الوقود', '${fuelType.fuelType}'),
                _buildMobileDataRow(
                    'الكمية المتوفرة', '${fuelType.amount} لتر'),
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
            width: 100.w,
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

  List<DataColumn> _buildTableColumns(
      bool isMobile, bool isTablet, bool isDesktop, bool isLargeDesktop) {
    return [
      DataColumn(
        label: _buildColumnHeader(
            'الكمية المتوفرة (لتر)', isMobile, isTablet, isDesktop,
            width: isTablet ? 120.w : (isDesktop ? 140.w : 160.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('نوع الوقود', isMobile, isTablet, isDesktop,
            width: isTablet ? 100.w : (isDesktop ? 120.w : 140.w)),
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

  List<DataRow> _buildTableRows(List<FuelAvailableAmount> fuelTypes,
      bool isMobile, bool isTablet, bool isDesktop, bool isLargeDesktop) {
    return fuelTypes.map((fuelType) {
      final isStriped = fuelTypes.indexOf(fuelType) % 2 == 1;

      return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary.withOpacity(0.04);
          }
          return isStriped ? AppColors.surface : Colors.white;
        }),
        cells: [
          _buildAmountCell(
              fuelType, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildFuelTypeCell(
              fuelType, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildIndexCell(fuelTypes.indexOf(fuelType), isMobile, isTablet,
              isDesktop, isLargeDesktop),
        ],
      );
    }).toList();
  }

  DataCell _buildAmountCell(FuelAvailableAmount fuelType, bool isMobile,
      bool isTablet, bool isDesktop, bool isLargeDesktop) {
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
            '${fuelType.amount}',
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

  DataCell _buildFuelTypeCell(FuelAvailableAmount fuelType, bool isMobile,
      bool isTablet, bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border:
                Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
          ),
          child: Text(
            '${fuelType.fuelType}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
              color: AppColors.primaryDark,
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
}
