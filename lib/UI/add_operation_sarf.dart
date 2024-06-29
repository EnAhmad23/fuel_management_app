import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/UI/Widgets/custom_switch.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:provider/provider.dart';

class AddSarf extends StatelessWidget {
  const AddSarf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
          'إنشاء عملية',
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
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('إنشاء عملية صرف جديدة',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                      ),
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
                                      child: MyTextFormField(
                                        fontSize: 16.sp,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter receiver name';
                                          }
                                          return null;
                                        },
                                        labelText: 'اسم المستلم',
                                        hintText: 'أدخل اسم المستلم',
                                        controller: provider.receiverName,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'المستهلك الفرعي',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: provider.subconName,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            items: provider.subconsumerNames
                                                ?.map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              provider.setSubConName(value);
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select a sub consumer';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'المستهلك الرئيسي',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: provider.conName,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            items: provider.consumerNames
                                                ?.map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              provider.setConName(value);
                                              provider.getSubonsumersNames(
                                                  provider.conName);
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select a main consumer';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
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
                                              'نوع الوقود',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: provider.fuelType,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                  value: 'بنزين',
                                                  child: Text('بنزين')),
                                              DropdownMenuItem(
                                                  value: 'سولار',
                                                  child: Text('سولار')),
                                            ],
                                            onChanged: (value) {
                                              provider.setFuelType(value);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          MyTextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter dischange number';
                                              }
                                              return null;
                                            },
                                            labelText: 'رقم سند الصرف',
                                            hintText: 'أدخل رقم الصرف',
                                            controller:
                                                provider.dischangeNumberCon,
                                          ),
                                        ],
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
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          TextFormField(
                                            controller: provider.dateCon,
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
                                    Expanded(
                                      child: MyTextFormField(
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter amount';
                                          }
                                          return null;
                                        },
                                        labelText: 'الكمية',
                                        hintText: 'أدخل كمية الوقود',
                                        controller: provider.amountCon,
                                      ),
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
                                    text: 'إنشاء', onTap: provider.onTopSarf),
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
