import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/UI/Widgets/custom_switch.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:provider/provider.dart';

import 'Widgets/My_dropdown.dart';

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
                                      child: MyDropdown(
                                        lable: 'المستهلك الفرعي',
                                        itemsList:
                                            provider.subconsumerNames ?? [],
                                        onchanged: (value) {
                                          provider.setSubConName(value);
                                        },
                                        value: provider.subconName,
                                        validator: provider.subNameValidet,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyDropdown(
                                        lable: 'المستهلك الرئيسي',
                                        itemsList: provider.consumerNames ?? [],
                                        onchanged: (value) {
                                          provider.setConName(value);
                                        },
                                        value: provider.conName,
                                        validator: provider.conNameValidet,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyDropdown(
                                        lable: 'نوع الوقود',
                                        itemsList: const ['بنزين', 'سولار'],
                                        onchanged: (value) {
                                          provider.setFuelType(value);
                                        },
                                        value: provider.fuelType,
                                        validator: provider.fuelTypeValidator,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyTextFormField(
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
                                  height: 20,
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
                                    text: 'إنشاء', onTap: provider.onTopSarf),
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
