import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      padding: const EdgeInsets.all(16.0),
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
                                        child: MyDropdown(
                                      lable: 'نوع التقرير',
                                      itemsList: const [
                                        'اختر نوع التقرير',
                                        'تقرير يومي',
                                        'تقرير لفترة'
                                      ],
                                      onchanged: (value) {
                                        if (value != 'اختر نوع التقرير') {
                                          provider.setReportType(value);
                                        } else {
                                          provider.setReportType(null);
                                        }
                                      },
                                      value: provider.reportType ??
                                          'اختر نوع التقرير',
                                      validator: (String) {},
                                    )),
                                    const SizedBox(
                                      width: 20,
                                    ),
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
                                      validator: (String) {},
                                    )),
                                    const SizedBox(
                                      width: 20,
                                    ),
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
                                          provider.setOperationType(value);
                                        } else {
                                          provider.setOperationType(null);
                                        }
                                      },
                                      value: provider.operationType ??
                                          'اختر نوع العملية',
                                      validator: (String) {},
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                provider.operationType == 'صرف'
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                MyTextFormField(
                                                  fontSize: 16,
                                                  validator: (String) {},
                                                  labelText: 'رقم سند الصرف',
                                                  hintText: 'أدخل رقم الصرف',
                                                  controller: provider
                                                      .dischangeNumberCon,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: MyTextFormField(
                                              fontSize: 16,
                                              validator: (value) {},
                                              labelText: 'اسم المستلم',
                                              hintText: 'أدخل اسم المستلم',
                                              controller: provider.receiverName,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: MyDropdown(
                                              lable: 'المستهلك',
                                              itemsList:
                                                  provider.subconsumerNames ??
                                                      [],
                                              onchanged: (value) {
                                                provider.setSubConName(value);
                                              },
                                              value: provider.subconName,
                                              validator: (String) {},
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: MyDropdown(
                                              lable: 'المستهلك الرئيسي',
                                              itemsList:
                                                  provider.consumerNames ?? [],
                                              onchanged: (value) {
                                                provider.setConName(value);
                                                provider
                                                    .getSubonsumersNames(value);
                                              },
                                              value: provider.conName,
                                              validator: (String) {},
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                provider.reportType == 'تقرير يومي'
                                    ? Column(
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            onTap: () async {
                                              var x = await showDatePicker(
                                                currentDate: provider.date,
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              provider.setDate(x);
                                            },
                                            style:
                                                const TextStyle(fontSize: 16),
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
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    'إلى تاريخ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
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
                                                    provider.setToDate(x);
                                                  },
                                                  validator:
                                                      provider.toDateValidet,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                  // textAlign: TextAlign.right,
                                                  controller:
                                                      provider.fromDateCon,
                                                  // textDirection: TextDirection.rtl,
                                                  decoration: InputDecoration(
                                                      // alignLabelWithHint: true,
                                                      hintText:
                                                          provider.toHintText,
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
                                                                provider.todate,
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(2101),
                                                          );
                                                          provider.setToDate(x);
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
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    ' من تاريخ ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
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
                                                    provider.setFromDate(x);
                                                  },
                                                  validator: (value) {
                                                    provider
                                                        .toDateValidet(value);
                                                  },
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                  // textAlign: TextAlign.right,
                                                  controller: provider.dateCon,
                                                  // textDirection: TextDirection.rtl,
                                                  decoration: InputDecoration(
                                                      // alignLabelWithHint: true,
                                                      hintText:
                                                          provider.fromHintText,
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
                                                                provider
                                                                    .fromdate,
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(2101),
                                                          );
                                                          provider
                                                              .setFromDate(x);
                                                        },
                                                      )),
                                                  readOnly: true,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                const SizedBox(
                                  height: 20,
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
                          Consumer<OpProvider>(builder: (context, provider, x) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: MyButton(
                                    text: 'بحث', onTap: provider.onTopSearch),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 10,
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
