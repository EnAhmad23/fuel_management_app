import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/views/Widgets/custom_switch.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';

class UpdateOperationSarf extends StatelessWidget {
  const UpdateOperationSarf({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
          'تعديل عملية',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 100.w),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: GetBuilder<OpController>(
                init: Get.find<OpController>(),
                builder: (op) {
                  return Form(
                    key: op.formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('تعديل عملية صرف',
                                style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          child: ListView(
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
                                            child: MyTextFormField(
                                          fontSize: 16.sp,
                                          validator: op.receiverValidet,
                                          labelText: 'اسم المستلم',
                                          hintText: 'ادخل اسم المستلم',
                                          controller: op.receiverName,
                                        )),
                                        SizedBox(width: 10.w),
                                        Expanded(child:
                                            GetBuilder<SubController>(
                                                builder: (sub) {
                                          return MyDropdown(
                                            hint: sub.dropdownValue,
                                            lable: 'المستهلك الفرعي',
                                            itemsList: const [],
                                            onchanged: (value) {
                                              sub.changeDropdownValue(value);
                                              sub.getHasRecord(value);
                                            },
                                            value: null,
                                            validator: sub.subNameValidtor,
                                          );
                                        })),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                            child: MyDropdown(
                                          hint: op.conName,
                                          lable: 'المستهلك الرئيسي',
                                          itemsList: const [],
                                          onchanged: (!op.disable)
                                              ? (value) {
                                                  if (value !=
                                                          'اختر المستهلك الرئيسي' &&
                                                      !op.disable) {
                                                    op.setConName(value);
                                                    op.getSubonsumersNames(
                                                        op.conName);
                                                  }
                                                }
                                              : (String? newValue) {},
                                          value: op.conName,
                                          validator: op.conNameValidet,
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
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
                                              op.setFuelType(value);
                                            } else {
                                              op.setFuelType(null);
                                            }
                                          },
                                          value:
                                              op.fuelType ?? 'اختر نوع الوقود',
                                          validator: op.fuelTypeValidator,
                                        )),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                            child: MyTextFormField(
                                          inputFormatters: const [],
                                          fontSize: 16.sp,
                                          validator: op.dischangeNumberValidet,
                                          labelText: 'رقم سند الصرف',
                                          hintText: 'ادخل رقم الصرف',
                                          controller: op.dischangeNumberCon,
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(' التاريخ ',
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                            SizedBox(height: 10.h),
                                            TextFormField(
                                              validator: op.dateValidet,
                                              style: TextStyle(fontSize: 16.sp),
                                              controller: op.dateCon,
                                              decoration: InputDecoration(
                                                hintText: op.hintText,
                                                border:
                                                    const OutlineInputBorder(),
                                                suffixIcon: InkWell(
                                                  child: const Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.black),
                                                  onTap: () async {
                                                    var x =
                                                        await showDatePicker(
                                                      currentDate: op.date,
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
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
                                        )),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                            child: MyTextFormField(
                                          inputFormatters: const [],
                                          fontSize: 16.sp,
                                          keyboardType: TextInputType.number,
                                          validator: op.amontValidet,
                                          labelText: 'الكمية',
                                          hintText: 'ادخل كمية الوقود',
                                          controller: op.amountCon,
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    GetBuilder<SubController>(builder: (sub) {
                                      return (sub.hasRcord)
                                          ? MyTextFormField(
                                              inputFormatters: const [],
                                              fontSize: 16.sp,
                                              validator: (value) {
                                                sub.recordValidtor(value);
                                                sub.getSubRecordName(
                                                    op.subconName);
                                                if (int.parse(value ?? '0') <
                                                    sub.lastRecord) {
                                                  return 'يجب ان تكون قيمة العداد أكبر او تساوي اخر قيمة (${sub.lastRecord})';
                                                }
                                                return null;
                                              },
                                              labelText: ' قراءة العداد',
                                              hintText: 'ادخل قراءة العداد',
                                              controller: op.recordCon,
                                            )
                                          : const SizedBox();
                                    }),
                                    SizedBox(height: 10.h),
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
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10.h),
                                    GetBuilder<OpController>(builder: (op) {
                                      return TextField(
                                        style: TextStyle(fontSize: 18.sp),
                                        textAlign: TextAlign.right,
                                        controller: op.description,
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
                              GetBuilder<OpController>(builder: (op) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: MyButton(
                                        text: 'تعديل',
                                        onTap: op.onTopUpdateSarf),
                                  ),
                                );
                              }),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
