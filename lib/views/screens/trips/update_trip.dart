import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/controllers/trip_controller.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:get/get.dart';

class UpdateTrip extends StatelessWidget {
  const UpdateTrip({super.key});

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
        'تعديل رحلة',
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
            Icons.edit_road_rounded,
            size: 48.sp,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(height: 12.h),
          Text(
            'تعديل رحلة',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textOnPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'قم بتعديل بيانات الرحلة',
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
      child: GetBuilder<TripController>(
        builder: (trip) {
          return Form(
            key: trip.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDropdownsSection(trip),
                SizedBox(height: 24.h),
                _buildDestinationField(trip),
                SizedBox(height: 24.h),
                _buildReasonField(trip),
                SizedBox(height: 24.h),
                _buildDateField(trip),
                SizedBox(height: 32.h),
                _buildSubmitButton(trip),
                SizedBox(height: 16.h),
                _buildCancelButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownsSection(TripController trip) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyDropdown(
                lable: 'المستهلك الفرعي',
                itemsList: trip.subNames ?? [],
                onchanged: (value) {
                  trip.setSubConName(value);
                },
                value: trip.subConName,
                validator: (p0) {
                  return null;
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: MyDropdown(
                lable: 'المستهلك الرئيسي',
                itemsList: trip.consumerNames ?? [],
                onchanged: (value) {
                  trip.setConName(value);
                  trip.getSubonsumersNames(trip.conName);
                },
                value: trip.conName,
                validator: trip.consumerValidator,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDestinationField(TripController trip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وجهة الرحلة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        MyTextFormField(
          validator: trip.roadValidator,
          labelText: 'وجهة الرحلة',
          hintText: 'أدخل وجهة الرحلة',
          controller: trip.roadCon,
        ),
      ],
    );
  }

  Widget _buildReasonField(TripController trip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'سبب الرحلة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        MyTextFormField(
          labelText: 'سبب الرحلة',
          hintText: 'أدخل سبب الرحلة',
          controller: trip.reasonCon,
          validator: (p0) {
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDateField(TripController trip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التاريخ',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          onTap: () async {
            var x = await showDatePicker(
              currentDate: trip.date,
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            trip.setDate(x);
          },
          style: TextStyle(fontSize: 16.sp),
          controller: trip.dateCon,
          decoration: InputDecoration(
            hintText: trip.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            suffixIcon: InkWell(
              child: Icon(
                Icons.calendar_today,
                color: AppColors.primary,
                size: 20.sp,
              ),
              onTap: () async {
                var x = await showDatePicker(
                  currentDate: trip.date,
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                trip.setDate(x);
              },
            ),
          ),
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(TripController trip) {
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
            HapticFeedback.lightImpact();
            trip.onTapUpdate();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_rounded,
                  size: 20.sp,
                  color: AppColors.textOnPrimary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'تعديل الرحلة',
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
