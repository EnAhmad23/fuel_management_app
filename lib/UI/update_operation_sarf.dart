import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/UI/Widgets/custom_switch.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:provider/provider.dart';

import 'Widgets/My_dropdown.dart';

class UpdateOperationSarf extends StatelessWidget {
  const UpdateOperationSarf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
          'تعديل عملية',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Consumer<OpProvider>(builder: (context, provider, x) {
              return Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      color: Colors.blue,
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('تعديل عملية صرف',
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
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyTextFormField(
                                        fontSize: 16,
                                        validator: provider.receiverValidet,
                                        labelText: 'اسم المستلم',
                                        hintText: 'أدخل اسم المستلم',
                                        controller: provider.receiverName,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Consumer<SubProvider>(
                                          builder: (context, sub, x) {
                                        return MyDropdown(
                                          lable: 'المستهلك الفرعي',
                                          itemsList: (!provider.disable)
                                              ? provider.subconsumerNames ?? []
                                              : [],
                                          onchanged: (!provider.disable)
                                              ? (value) {
                                                  provider.setSubConName(value);
                                                  sub.getHasRecord(value);
                                                }
                                              : (newValue) {},
                                          value: provider.subconName,
                                          validator: provider.subNameValidet,
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyDropdown(
                                        lable: 'المستهلك الرئيسي',
                                        itemsList: (!provider.disable)
                                            ? provider.consumerNames ?? []
                                            : [],
                                        onchanged: (!provider.disable)
                                            ? (value) {
                                                if (value !=
                                                        'اختر المستهلك الرئيسي' &&
                                                    !provider.disable) {
                                                  provider.setConName(value);
                                                  provider.getSubonsumersNames(
                                                      provider.conName);
                                                  log('=====================================${provider.subconName}');
                                                  // provider.setSubConName(provider
                                                  //     .operationT
                                                  //     ?.subConsumerDetails);
                                                  log('33333333333333333333333${provider.operationT?.subConsumerDetails}');
                                                  // provider.setSubConName(provider
                                                  //     .operationT!
                                                  //     .subConsumerDetails);
                                                }
                                              }
                                            : (String? newValue) {},
                                        value: provider.conName,
                                        validator: provider.conNameValidet,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
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
                                            provider.setFuelType(value);
                                          } else {
                                            provider.setFuelType(null);
                                          }
                                        },
                                        value: provider.fuelType ??
                                            'اختر نوع الوقود',
                                        validator: provider.fuelTypeValidator,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyTextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        fontSize: 16,
                                        validator:
                                            provider.dischangeNumberValidet,
                                        labelText: 'رقم سند الصرف',
                                        hintText: 'أدخل رقم الصرف',
                                        controller: provider.dischangeNumberCon,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
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
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            validator: provider.dateValidet,
                                            style:
                                                const TextStyle(fontSize: 16),
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyTextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        fontSize: 16,
                                        keyboardType: TextInputType.number,
                                        validator: provider.amontValidet,
                                        labelText: 'الكمية',
                                        hintText: 'أدخل كمية الوقود',
                                        controller: provider.amountCon,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Consumer<SubProvider>(
                                  builder: (context, sub, child) {
                                    return (sub.hasRcord)
                                        ? MyTextFormField(
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            fontSize: 16,
                                            validator: (value) {
                                              sub.recordValidtor(value);
                                              sub.getSubRecordName(
                                                  provider.subconName);
                                              if (int.parse(value ?? '0') <
                                                  sub.lastRecord) {
                                                return 'يجب ان تكون قيمة العداد أكبر او تساوي اخر قيمة (${sub.lastRecord})';
                                              }
                                            },
                                            labelText: ' قراءة العداد',
                                            hintText: 'أدخل قراءة العداد',
                                            controller: provider.recordCon,
                                          )
                                        : const SizedBox();
                                  },
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const CustomSwitch(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
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
                                const SizedBox(
                                    height:
                                        10), // Add some space between the label and the TextField
                                Consumer<OpProvider>(
                                    builder: (context, provider, x) {
                                  return TextField(
                                    style: const TextStyle(fontSize: 18),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer2<OpProvider, SubProvider>(
                              builder: (context, provider, sub, x) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: MyButton(
                                    text: 'تعديل',
                                    onTap: provider.onTopUpdateSarf),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 30,
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
