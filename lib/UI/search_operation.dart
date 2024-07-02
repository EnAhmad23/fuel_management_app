import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/UI/Widgets/My_dropdown.dart';
import 'package:provider/provider.dart';

import '../Controllers/op_provider.dart';
import 'Widgets/custom_switch.dart';
import 'Widgets/myTextFormField.dart';
import 'Widgets/my_button.dart';

class SearchOperation extends StatelessWidget {
  const SearchOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
          'بحث',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 100.w),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Consumer<OpProvider>(builder: (context, provider, x) {
              return Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    Container(
                      height: 60.h,
                      color: Colors.blue,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
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
                                        provider.setReportType(value);
                                      },
                                      value: provider.reportType,
                                      validator: (String) {},
                                    )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                        child: MyDropdown(
                                      lable: 'نوع الوقود',
                                      itemsList: const ['بنزين', 'سولار'],
                                      onchanged: (value) {
                                        provider.setFuelType(value);
                                      },
                                      value: provider.fuelType,
                                      validator: provider.fuelTypeValidator,
                                    )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                        child: MyDropdown(
                                      lable: 'النوع',
                                      itemsList: const ['صرف', 'وارد'],
                                      onchanged: (value) {
                                        provider.setOperationType(value);
                                      },
                                      value: provider.operationType,
                                      validator: (String) {},
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          MyTextFormField(
                                            fontSize: 16.sp,
                                            validator:
                                                provider.dischangeNumberValidet,
                                            labelText: 'رقم سند الصرف',
                                            hintText: 'أدخل رقم الصرف',
                                            controller:
                                                provider.dischangeNumberCon,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Expanded(
                                      child: MyTextFormField(
                                        fontSize: 16.sp,
                                        validator: provider.receiverValidet,
                                        labelText: 'اسم المستلم',
                                        hintText: 'أدخل اسم المستلم',
                                        controller: provider.receiverName,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Expanded(
                                      child: MyDropdown(
                                        lable: 'المستهلك',
                                        itemsList:
                                            provider.subconsumerNames ?? [],
                                        onchanged: (value) {
                                          provider.setSubConName(value);
                                        },
                                        value: provider.subconName,
                                        validator: provider.subNameValidet,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Expanded(
                                      child: MyDropdown(
                                        lable: 'المستهلك الرئيسي',
                                        itemsList: provider.consumerNames ?? [],
                                        onchanged: (value) {
                                          provider.setConName(value);
                                          provider.getSubonsumersNames(value);
                                        },
                                        value: provider.conName,
                                        validator: provider.conNameValidet,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              ' التاريخ ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w800),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          TextFormField(
                                            style: TextStyle(fontSize: 16.sp),
                                            // textAlign: TextAlign.right,
                                            controller: provider.dateCon,
                                            // textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                                // alignLabelWithHint: true,
                                                hintText: provider.hintText,
                                                border:
                                                    const OutlineInputBorder(),
                                                suffixIcon: InkWell(
                                                  child: const Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.black,
                                                  ),
                                                  onTap: () async {
                                                    var x =
                                                        await showDatePicker(
                                                      currentDate:
                                                          provider.date,
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    provider.setDate(x);
                                                  },
                                                )),
                                            readOnly: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                const CustomSwitch(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                            ), // Add padding as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  textAlign: TextAlign.right,
                                  'وصف',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight
                                              .bold), // Customize the style as needed
                                ),
                                SizedBox(
                                    height: 10
                                        .h), // Add some space between the label and the TextField
                                Consumer<OpProvider>(
                                    builder: (context, provider, x) {
                                  return TextField(
                                    style: TextStyle(fontSize: 18.sp),
                                    // textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    controller: provider.description,
                                    maxLines: 3, // Set the number of rows
                                    decoration: const InputDecoration(
                                      hintText: '... أدخل ',
                                      border:
                                          OutlineInputBorder(), // Add border similar to 'form-control'
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Consumer<OpProvider>(builder: (context, provider, x) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: MyButton(
                                    text: 'بحث', onTap: provider.onTopSarf),
                              ),
                            );
                          }),
                          SizedBox(
                            height: 30.h,
                          )
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
