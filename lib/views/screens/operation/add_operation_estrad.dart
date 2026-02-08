import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/views/Widgets/custom_switch.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:get/get.dart';

class AddOperationEstrad extends StatelessWidget {
  const AddOperationEstrad({super.key});

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
        'إنشاء عملية وارد',
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),
            _buildFormCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_rounded,
            size: 40.sp,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(height: 10.h),
          Text(
            'إنشاء عملية وارد جديدة',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textOnPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'قم بإدخال بيانات عملية الوارد الجديدة',
            style: TextStyle(
              fontSize: 13.sp,
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
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: GetBuilder<OpController>(
        init: Get.find<OpController>(),
        builder: (provider) {
          return Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDateAmountFuelSection(provider),
                SizedBox(height: 20.h),
                const CustomSwitch(),
                SizedBox(height: 20.h),
                _buildDescriptionSection(provider),
                SizedBox(height: 24.h),
                _buildSubmitButton(provider),
                SizedBox(height: 12.h),
                _buildCancelButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateAmountFuelSection(OpController provider) {
    return Row(
      children: [
        Expanded(
          child: _buildDateField(provider),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: MyTextFormField(
            inputFormatters: const [],
            fontSize: 15.sp,
            validator: provider.amontValidet,
            labelText: 'الكمية',
            hintText: 'ادخل كمية الوقود',
            controller: provider.amountCon,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: MyDropdown(
            lable: 'نوع الوقود',
            itemsList: const ['اختر نوع الوقود', 'بنزين', 'سولار'],
            onchanged: (value) {
              if (value != 'اختر نوع الوقود') {
                provider.setFuelType(value);
              } else {
                provider.setFuelType(null);
              }
            },
            value: provider.fuelType ?? 'اختر نوع الوقود',
            validator: provider.fuelTypeValidator,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(OpController provider) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التاريخ',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textOnBackground,
            ),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            validator: provider.dateValidet,
            onTap: () async {
              var x = await showDatePicker(
                currentDate: provider.date,
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              provider.setDate(x);
            },
            style: TextStyle(fontSize: 15.sp),
            controller: provider.dateCon,
            decoration: InputDecoration(
              hintText: provider.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              suffixIcon: InkWell(
                child: Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                  size: 19.sp,
                ),
                onTap: () async {
                  var x = await showDatePicker(
                    currentDate: provider.date,
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  provider.setDate(x);
                },
              ),
            ),
            readOnly: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(OpController provider) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'وصف',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textOnBackground,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.right,
            controller: provider.description,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: '... أدخل ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(OpController provider) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: () {
            HapticFeedback.lightImpact();
            provider.onTopWared();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.save_rounded,
                  size: 19.sp,
                  color: AppColors.textOnPrimary,
                ),
                SizedBox(width: 7.w),
                Text(
                  'إنشاء العملية',
                  style: TextStyle(
                    fontSize: 15.sp,
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
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: () {
            HapticFeedback.lightImpact();
            Get.back();
          },
          child: Center(
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontSize: 15.sp,
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
