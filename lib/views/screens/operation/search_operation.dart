import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';
import 'package:fuel_management_app/views/Widgets/custom_switch.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/core/constant/app_colors.dart';

class SearchOperation extends StatelessWidget {
  const SearchOperation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textOnBackground,
        title: Text(
          'بحث العمليات',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<OpController>(
        init: Get.find<OpController>(),
        builder: (opPro) {
          return Form(
            key: opPro.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'بحث العمليات',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            SizedBox(width: 10.w),
                            Row(
                              children: [
                                Expanded(
                                    child: MyDropdown(
                                  lable: 'نوع التقرير',
                                  itemsList: const [
                                    'اختر نوع التقرير',
                                    'تقرير يومي',
                                    'تقرير لفترة'
                                  ],
                                  onchanged: (value) {
                                    if (value != 'اختر نوع التقرير') {
                                      opPro.setReportType(value);
                                    } else {
                                      opPro.setReportType(null);
                                    }
                                  },
                                  value: opPro.reportType ?? 'اختر نوع التقرير',
                                  validator: (String) {
                                    return null;
                                  },
                                )),
                                SizedBox(width: 20.w),
                                Expanded(
                                    child: MyDropdown(
                                  lable: 'نوع الوقود',
                                  itemsList: const [
                                    'اختر نوع الوقود',
                                    'بنزين',
                                    'سولار'
                                  ],
                                  onchanged: (value) {
                                    if (value != 'اختر نوع الوقود') {
                                      opPro.setFuelType(value);
                                    } else {
                                      opPro.setFuelType(null);
                                    }
                                  },
                                  value: opPro.fuelType ?? 'اختر نوع الوقود',
                                  validator: (String) {
                                    return null;
                                  },
                                )),
                                SizedBox(width: 20.w),
                                Expanded(
                                    child: MyDropdown(
                                  lable: 'النوع',
                                  itemsList: const [
                                    'اختر نوع العملية',
                                    'صرف',
                                    'وارد'
                                  ],
                                  onchanged: (value) {
                                    if (value != 'اختر نوع العملية') {
                                      opPro.setOperationType(value);
                                    } else {
                                      opPro.setOperationType(null);
                                    }
                                  },
                                  value:
                                      opPro.operationType ?? 'اختر نوع العملية',
                                  validator: (String) {
                                    return null;
                                  },
                                )),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            opPro.operationType == 'صرف'
                                ? Row(
                                    children: [
                                      Expanded(
                                          child: MyTextFormField(
                                        inputFormatters: const [],
                                        fontSize: 16.sp,
                                        validator: (String) {
                                          return null;
                                        },
                                        labelText: 'رقم سند الصرف',
                                        hintText: 'ادخل رقم الصرف',
                                        controller: opPro.dischangeNumberCon,
                                      )),
                                      SizedBox(width: 15.w),
                                      Expanded(
                                          child: MyTextFormField(
                                        fontSize: 16.sp,
                                        validator: (value) {
                                          return null;
                                        },
                                        labelText: 'اسم المستلم',
                                        hintText: 'ادخل اسم المستلم',
                                        controller: opPro.receiverName,
                                      )),
                                      SizedBox(width: 15.w),
                                      Expanded(
                                          child: MyDropdown(
                                        lable: 'المستهلك',
                                        itemsList: opPro.subconsumerNames ?? [],
                                        onchanged: (value) {
                                          opPro.setSubConName(value);
                                        },
                                        value: opPro.subconName,
                                        validator: (String) {
                                          return null;
                                        },
                                      )),
                                      SizedBox(width: 15.w),
                                      Expanded(
                                          child: MyDropdown(
                                        lable: 'المستهلك الرئيسي',
                                        itemsList: opPro.consumerNames ?? [],
                                        onchanged: (value) {
                                          opPro.setConName(value);
                                          opPro.getSubonsumersNames(value);
                                        },
                                        value: opPro.conName,
                                        validator: (String) {
                                          return null;
                                        },
                                      )),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(height: 20.h),
                            opPro.reportType == 'تقرير يومي'
                                ? Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(' التاريخ ',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w800)),
                                      ),
                                      SizedBox(height: 10.h),
                                      TextFormField(
                                        onTap: () async {
                                          var x = await showDatePicker(
                                            currentDate: opPro.date,
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          opPro.setDate(x);
                                        },
                                        style: TextStyle(fontSize: 16.sp),
                                        controller: opPro.dateCon,
                                        decoration: InputDecoration(
                                          hintText: opPro.hintText,
                                          border: const OutlineInputBorder(),
                                          suffixIcon: InkWell(
                                            child: const Icon(
                                                Icons.calendar_today,
                                                color: Colors.black),
                                            onTap: () async {
                                              var x = await showDatePicker(
                                                currentDate: opPro.date,
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              opPro.setDate(x);
                                            },
                                          ),
                                        ),
                                        readOnly: true,
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('إلى تاريخ',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w800)),
                                          ),
                                          SizedBox(height: 10.h),
                                          TextFormField(
                                            onTap: () async {
                                              var x = await showDatePicker(
                                                currentDate: opPro.date,
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              opPro.setToDate(x);
                                            },
                                            validator: opPro.toDateValidet,
                                            style: TextStyle(fontSize: 16.sp),
                                            controller: opPro.fromDateCon,
                                            decoration: InputDecoration(
                                              hintText: opPro.toHintText,
                                              border:
                                                  const OutlineInputBorder(),
                                              suffixIcon: InkWell(
                                                child: const Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.black),
                                                onTap: () async {
                                                  var x = await showDatePicker(
                                                    currentDate: opPro.todate,
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                  );
                                                  opPro.setToDate(x);
                                                },
                                              ),
                                            ),
                                            readOnly: true,
                                          ),
                                        ],
                                      )),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(' من تاريخ ',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w800)),
                                          ),
                                          SizedBox(height: 10.h),
                                          TextFormField(
                                            onTap: () async {
                                              var x = await showDatePicker(
                                                currentDate: opPro.date,
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              opPro.setFromDate(x);
                                            },
                                            validator: (value) {
                                              opPro.toDateValidet(value);
                                              return null;
                                            },
                                            style: TextStyle(fontSize: 16.sp),
                                            controller: opPro.dateCon,
                                            decoration: InputDecoration(
                                              hintText: opPro.fromHintText,
                                              border:
                                                  const OutlineInputBorder(),
                                              suffixIcon: InkWell(
                                                child: const Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.black),
                                                onTap: () async {
                                                  var x = await showDatePicker(
                                                    currentDate: opPro.fromdate,
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                  );
                                                  opPro.setFromDate(x);
                                                },
                                              ),
                                            ),
                                            readOnly: true,
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                            SizedBox(height: 20.h),
                            const CustomSwitch(),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('وصف',
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.h),
                            GetBuilder<OpController>(builder: (opPro) {
                              return TextField(
                                style: TextStyle(fontSize: 18.sp),
                                textAlign: TextAlign.right,
                                controller: opPro.description,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  hintText: '... أدخل ',
                                  border: OutlineInputBorder(),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GetBuilder<OpController>(builder: (opPro) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child:
                                MyButton(text: 'بحث', onTap: opPro.onTopSearch),
                          ),
                        );
                      }),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
