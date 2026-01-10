import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/views/Widgets/custom_switch.dart';

class AddSarf extends StatelessWidget {
  const AddSarf({super.key});

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
        'إنشاء عملية صرف',
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
            Icons.local_gas_station_rounded,
            size: 48.sp,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(height: 12.h),
          Text(
            'إنشاء عملية صرف جديدة',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textOnPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'قم بإدخال بيانات عملية الصرف الجديدة',
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
      child: GetBuilder<OpController>(
        builder: (op) {
          return Form(
            key: op.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDropdownsSection(op),
                SizedBox(height: 24.h),
                _buildFuelAndDischargeSection(op),
                SizedBox(height: 24.h),
                _buildDateAndAmountSection(op),
                SizedBox(height: 24.h),
                _buildRecordField(op),
                SizedBox(height: 24.h),
                const CustomSwitch(),
                SizedBox(height: 24.h),
                _buildDescriptionSection(op),
                SizedBox(height: 32.h),
                _buildSubmitButton(op),
                SizedBox(height: 16.h),
                _buildCancelButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownsSection(OpController op) {
    return Row(
      children: [
        Expanded(
          child: _buildReceiverField(op),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GetBuilder<SubController>(
            builder: (sub) {
              return MyDropdown(
                lable: 'المستهلك الفرعي',
                itemsList: op.subconsumerNames ?? [],
                onchanged: (value) {
                  op.setSubConName(value);
                  sub.getHasRecord(value);
                },
                value: op.subconName,
                validator: op.subNameValidet,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: MyDropdown(
            lable: 'المستهلك الرئيسي',
            itemsList: op.consumerNames ?? [],
            onchanged: (value) {
              if (value != 'اختر المستهلك الرئيسي') {
                op.setConName(value);
                op.getSubonsumersNames(op.conName);
              }
            },
            value: op.conName,
            validator: op.conNameValidet,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiverField(OpController op) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اسم المستلم',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        MyTextFormField(
          fontSize: 16.sp,
          validator: op.receiverValidet,
          labelText: 'اسم المستلم',
          hintText: 'ادخل اسم المستلم',
          controller: op.receiverName,
        ),
      ],
    );
  }

  Widget _buildFuelAndDischargeSection(OpController op) {
    return Row(
      children: [
        Expanded(
          child: MyDropdown(
            lable: 'نوع الوقود',
            itemsList: const ['اختر نوع الوقود', 'بنزين', 'سولار'],
            onchanged: (value) {
              if (value != 'اختر نوع الوقود') {
                op.setFuelType(value);
              } else {
                op.setFuelType(null);
              }
            },
            value: op.fuelType ?? 'اختر نوع الوقود',
            validator: op.fuelTypeValidator,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: MyTextFormField(
            fontSize: 16.sp,
            validator: op.dischangeNumberValidet,
            labelText: 'رقم سند الصرف',
            hintText: 'ادخل رقم الصرف',
            controller: op.dischangeNumberCon,
          ),
        ),
      ],
    );
  }

  Widget _buildDateAndAmountSection(OpController op) {
    return Row(
      children: [
        Expanded(
          child: _buildDateField(op),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: MyTextFormField(
            fontSize: 16.sp,
            keyboardType: TextInputType.number,
            validator: op.amontValidet,
            labelText: 'الكمية',
            hintText: 'ادخل كمية الوقود',
            controller: op.amountCon,
            inputFormatters: const [],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(OpController op) {
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
              currentDate: op.date,
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            op.setDate(x);
          },
          validator: op.dateValidet,
          style: TextStyle(fontSize: 16.sp),
          controller: op.dateCon,
          decoration: InputDecoration(
            hintText: op.hintText,
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
                  currentDate: op.date,
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                op.setDate(x);
              },
            ),
          ),
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildRecordField(OpController op) {
    return GetBuilder<SubController>(
      builder: (sub) {
        if (!sub.hasRcord) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'قراءة العداد',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textOnBackground,
              ),
            ),
            SizedBox(height: 8.h),
            MyTextFormField(
              fontSize: 16.sp,
              validator: (value) {
                sub.recordValidtor(value);
                sub.getSubRecordName(op.subconName);
                if (int.parse(value ?? '0') < sub.lastRecord) {
                  return 'يجب ان تكون قيمة العداد أكبر او تساوي اخر قيمة (${sub.lastRecord})';
                }
                return null;
              },
              labelText: ' قراءة العداد',
              hintText: 'ادخل قراءة العداد',
              controller: op.recordCon,
            ),
          ],
        );
      },
    );
  }

  Widget _buildDescriptionSection(OpController op) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وصف',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        GetBuilder<OpController>(
          builder: (op) {
            return TextField(
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.right,
              controller: op.description,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: '... أدخل ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(OpController op) {
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
            op.onTopSarf();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.save_rounded,
                  size: 20.sp,
                  color: AppColors.textOnPrimary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'إنشاء العملية',
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
