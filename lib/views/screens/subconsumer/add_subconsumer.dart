import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';

class AddSubconsumer extends StatelessWidget {
  const AddSubconsumer({super.key});

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
        'إنشاء مستهلك فرعي',
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
            Icons.person_add_alt_1_rounded,
            size: 48.sp,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(height: 12.h),
          Text(
            'إضافة مستهلك فرعي جديد',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textOnPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'قم بإدخال بيانات المستهلك الفرعي الجديد',
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
      child: GetBuilder<SubController>(
        builder: (sub) {
          return Form(
            key: sub.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMainConsumerDropdown(sub),
                SizedBox(height: 24.h),
                _buildSubconsumerNameField(sub),
                SizedBox(height: 24.h),
                _buildDescriptionField(sub),
                SizedBox(height: 24.h),
                _buildHasRecordSection(sub),
                SizedBox(height: 24.h),
                _buildRecordFields(sub),
                SizedBox(height: 32.h),
                _buildSubmitButton(sub),
                SizedBox(height: 16.h),
                _buildCancelButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainConsumerDropdown(SubController sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المستهلك الرئيسي',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            value: sub.dropdownValue,
            onChanged: (String? newValue) {
              sub.changeDropdownValue(newValue);
            },
            items: sub.consumersNames
                ?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                alignment: Alignment.centerRight,
                child: Text(value),
              );
            }).toList(),
            validator: sub.conNameValidtor,
          ),
        ),
      ],
    );
  }

  Widget _buildSubconsumerNameField(SubController sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اسم المستهلك الفرعي',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        MyTextFormField(
          validator: sub.subNameValidtor,
          labelText: 'اسم المستهلك',
          hintText: 'أدخل اسم المستهلك',
          controller: sub.subName,
          fontSize: 16.sp,
        ),
      ],
    );
  }

  Widget _buildDescriptionField(SubController sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تفاصيل المستهلك',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        MyTextFormField(
          labelText: 'تفاصيل المستهلك',
          hintText: 'أدخل تفاصيل المستهلك',
          controller: sub.subDescription,
          fontSize: 16.sp,
        ),
      ],
    );
  }

  Widget _buildHasRecordSection(SubController sub) {
    return GetBuilder<SubController>(
      builder: (sub) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'له عداد',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textOnBackground,
              ),
            ),
            SizedBox(width: 12.w),
            Checkbox(
              value: sub.hasRcord,
              onChanged: (value) => sub.changRecord(value ?? false),
              activeColor: AppColors.primary,
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecordFields(SubController sub) {
    return GetBuilder<SubController>(
      builder: (sub) {
        if (!sub.hasRcord) return const SizedBox();

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDateField(sub),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildInitialReadingField(sub),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateField(SubController sub) {
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
          style: TextStyle(fontSize: 16.sp),
          controller: sub.dateCon,
          decoration: InputDecoration(
            hintText: sub.hintText,
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
                  currentDate: sub.date,
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                sub.setDate(x);
              },
            ),
          ),
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildInitialReadingField(SubController sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'القراءة الأولية',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnBackground,
          ),
        ),
        SizedBox(height: 8.h),
        MyTextFormField(
          inputFormatters: const [],
          fontSize: 16.sp,
          labelText: 'القراءة الاولية',
          hintText: 'أدخل القراءة الأولى',
          controller: sub.recordCon,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(SubController sub) {
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
            sub.onTapButton();
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
                  'إنشاء المستهلك الفرعي',
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
