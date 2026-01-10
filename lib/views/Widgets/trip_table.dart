import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/controllers/trip_controller.dart';
import 'package:fuel_management_app/models/trip.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant/app_colors.dart';

class TripTable extends StatelessWidget {
  final List<Trip> trips;
  const TripTable({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    log('operations $trips');

    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isLargeDesktop = screenWidth >= 1440;

    if (trips.isEmpty) {
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
                'لا توجد رحلات لعرضها',
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
                trips, isMobile, isTablet, isDesktop, isLargeDesktop),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
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
                    _buildMobileActions(trip),
                  ],
                ),
                SizedBox(height: 12.h),

                // Data rows
                _buildMobileDataRow('التاريخ', '${trip.formattedDate}'),
                _buildMobileDataRow('المسافة',
                    '${trip.distation != null ? (trip.distation! < 0 ? 0 : trip.distation! / 1000) : 0.0} كم'),
                _buildMobileDataRow('سبب الرحلة', '${trip.cause}'),
                _buildMobileDataRow('وجهة الرحلة', '${trip.road}'),
                _buildMobileDataRow('المستهلك', trip.subconName ?? '_'),
                _buildMobileDataRow('الحالة', '${trip.status}'),
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

  Widget _buildMobileActions(Trip trip) {
    return GetBuilder<TripController>(
      init: Get.find<TripController>(),
      builder: (pro) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trip.status != Status.finished.stringValue &&
                trip.status != Status.canceled.stringValue) ...[
              _buildMobileActionButton(
                icon: Icons.delete,
                color: AppColors.errorDark,
                onTap: () => _showDeleteDialog(trip, pro),
              ),
              SizedBox(width: 8.w),
              _buildMobileActionButton(
                icon: Icons.edit,
                color: AppColors.successDark,
                onTap: () => pro.goToUpdate(trip),
              ),
            ] else
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '---',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
          ],
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
        label: _buildColumnHeader('خيارات', isMobile, isTablet, isDesktop,
            width: isTablet ? 60.w : (isDesktop ? 70.w : 80.w)),
      ),
      DataColumn(
        label: _buildColumnHeader(
            'المسافة المقطوعة', isMobile, isTablet, isDesktop,
            width: isTablet ? 80.w : (isDesktop ? 90.w : 100.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('تاريخ الرحلة', isMobile, isTablet, isDesktop,
            width: isTablet ? 60.w : (isDesktop ? 70.w : 80.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('سبب الرحلة', isMobile, isTablet, isDesktop,
            width: isTablet ? 70.w : (isDesktop ? 80.w : 90.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('وجهة الرحلة', isMobile, isTablet, isDesktop,
            width: isTablet ? 70.w : (isDesktop ? 80.w : 90.w)),
      ),
      DataColumn(
        label: _buildColumnHeader('اسم المستهلك', isMobile, isTablet, isDesktop,
            width: isTablet ? 80.w : (isDesktop ? 90.w : 100.w)),
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

  List<DataRow> _buildTableRows(List<Trip> trips, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return trips.map((trip) {
      int record = trip.recordAfter ?? 0 - (trip.recordBefor ?? 0);
      final isStriped = trips.indexOf(trip) % 2 == 1;

      return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary.withOpacity(0.04);
          }
          return isStriped ? AppColors.surface : Colors.white;
        }),
        cells: [
          _buildSettingsCell(
              trip, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildStatusCell(trip, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildDistanceCell(
              trip, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildDateCell(trip, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildCauseCell(trip, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildRoadCell(trip, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildConsumerCell(
              trip, isMobile, isTablet, isDesktop, isLargeDesktop),
          _buildIndexCell(trips.indexOf(trip), isMobile, isTablet, isDesktop,
              isLargeDesktop),
        ],
      );
    }).toList();
  }

  DataCell _buildSettingsCell(Trip trip, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Padding(
        padding: EdgeInsets.symmetric(vertical: isTablet ? 12.h : 16.h),
        child: trip.status == Status.finished.stringValue ||
                trip.status == Status.canceled.stringValue
            ? Center(
                child: Text(
                  '---',
                  style: TextStyle(
                    fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
                    color: AppColors.textOnBackground.withOpacity(0.5),
                  ),
                ),
              )
            : GetBuilder<TripController>(
                init: Get.find<TripController>(),
                builder: (pro) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildActionButton(
                        icon: Icons.delete,
                        color: AppColors.errorDark,
                        onTap: () => _showDeleteDialog(trip, pro),
                        isMobile: isMobile,
                        isTablet: isTablet,
                        isDesktop: isDesktop,
                        isLargeDesktop: isLargeDesktop,
                      ),
                      SizedBox(width: 4.w),
                      _buildActionButton(
                        icon: Icons.edit,
                        color: AppColors.successDark,
                        onTap: () => pro.goToUpdate(trip),
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

  DataCell _buildStatusCell(Trip trip, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: GetBuilder<TripController>(
          init: Get.find<TripController>(),
          builder: (pro) {
            if (trip.status == Status.canceled.stringValue ||
                trip.status == Status.finished.stringValue) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '${trip.status}',
                  style: TextStyle(
                    fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            } else if (trip.status == Status.created.stringValue) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: InkWell(
                  onTap: () {
                    pro.startTrip(trip);
                    pro.getTrips();
                  },
                  child: Text(
                    'بدأ الرحلة',
                    style: TextStyle(
                      fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
                      color: AppColors.successDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: InkWell(
                  onTap: () {
                    pro.endTrip(trip);
                    pro.getTrips();
                  },
                  child: Text(
                    'إنهاء الرحلة',
                    style: TextStyle(
                      fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
                      color: AppColors.errorDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  DataCell _buildDistanceCell(Trip trip, bool isMobile, bool isTablet,
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${trip.distation != null ? (trip.distation! < 0 ? 0 : trip.distation! / 1000) : 0.0}',
                style: TextStyle(
                  fontSize: isTablet ? 10.sp : (isDesktop ? 11.sp : 12.sp),
                  color: AppColors.accentDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                'كم',
                style: TextStyle(
                  fontSize: isTablet ? 9.sp : (isDesktop ? 10.sp : 11.sp),
                  color: AppColors.textOnBackground.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataCell _buildDateCell(Trip trip, bool isMobile, bool isTablet,
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
            '${trip.formattedDate}',
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

  DataCell _buildCauseCell(Trip trip, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 70.w : (isDesktop ? 80.w : 90.w),
          ),
          child: Text(
            '${trip.cause}',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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

  DataCell _buildRoadCell(Trip trip, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 70.w : (isDesktop ? 80.w : 90.w),
          ),
          child: Text(
            '${trip.road}',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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

  DataCell _buildConsumerCell(Trip trip, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) {
    return DataCell(
      Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 80.w : (isDesktop ? 90.w : 100.w),
          ),
          child: Text(
            trip.subconName ?? '_',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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

  void _showDeleteDialog(Trip trip, TripController pro) {
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
              'هل أنت متأكد من حذف هذه الرحلة؟',
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
                      pro.deleteTrip(trip.id!);
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
