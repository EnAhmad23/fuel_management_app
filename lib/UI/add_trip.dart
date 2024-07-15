import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Controllers/trip_provider.dart';
import 'package:fuel_management_app/Model/subconsumer.dart';
import 'package:fuel_management_app/Model/trip.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Widgets/My_dropdown.dart';

class AddTrip extends StatelessWidget {
  const AddTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'إنشاء رحلة',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Consumer<TripProvider>(builder: (context, provider, x) {
                return Form(
                  key: provider.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60.h,
                          color: Colors.blue,
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyDropdown(
                                        lable: 'المستهلك الفرعي',
                                        itemsList: provider.subNames ?? [],
                                        onchanged: (value) {
                                          provider.setSubConName(value);
                                        },
                                        value: provider.subConName,
                                        validator: (p0) {},
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
                                          provider.getSubonsumersNames(
                                              provider.conName);
                                        },
                                        value: provider.conName,
                                        validator: provider.consumerValidator,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MyTextFormField(
                                  validator: provider.roadValidator,
                                  labelText: 'وجهة الرحلة',
                                  hintText: 'أدخل وجهة الرحلة',
                                  controller: provider.roadCon,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MyTextFormField(
                                  labelText: 'سبب الرحلة',
                                  hintText: 'أدخل سبب الرحلة',
                                  controller: provider.reasonCon,
                                  validator: (p0) {},
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        ' التاريخ ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w800),
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
                                      style: const TextStyle(fontSize: 16),
                                      // textAlign: TextAlign.right,
                                      controller: provider.dateCon,
                                      // textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                          // alignLabelWithHint: true,
                                          hintText: provider.hintText,
                                          border: const OutlineInputBorder(),
                                          suffixIcon: InkWell(
                                            child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.black,
                                            ),
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
                                          )),
                                      readOnly: true,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Consumer<SubProvider>(
                                    builder: (context, subPr, x) {
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: MyButton(
                                      text: 'إنشاء',
                                      onTap: provider.onTapButton,
                                    ),
                                  );
                                }),
                                const SizedBox(height: 20),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
