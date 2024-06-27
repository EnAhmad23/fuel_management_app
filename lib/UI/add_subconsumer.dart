import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/subconsumer.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddSubconsumer extends StatelessWidget {
  const AddSubconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'إنشاء مستهلك فرعي',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 100.w),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Consumer<SubProvider>(builder: (context, provider, x) {
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
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('المستهلك الرئيسي',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                DropdownButtonFormField<String>(
                                    // alignment: Alignment.centerRight,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    value: provider.dropdownValue,
                                    onChanged: (String? newValue) {
                                      provider.changeDropdownValue(newValue);
                                    },
                                    items: provider.consumersNames
                                        ?.map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        alignment: Alignment.centerRight,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    validator: provider.conNameValidtor),
                                SizedBox(
                                  height: 20.h,
                                ),
                                MyTextFormField(
                                  validator: provider.subNameValidtor,
                                  labelText: 'اسم المستهلك',
                                  hintText: 'أدخل اسم المستهلك',
                                  controller: provider.subName,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                MyTextFormField(
                                  labelText: 'تفاصيل المستهلك',
                                  hintText: 'أدخل تفاصيل المستهلك',
                                  controller: provider.subDescription,
                                  validator: provider.descriptionValidtor,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Consumer<SubProvider>(
                                    builder: (context, subPro, x) {
                                  return Align(
                                    alignment: Alignment.topRight,
                                    child: CheckboxListTile(
                                      title: Text(
                                        'له عداد',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      value: subPro.hasRcord ?? false,
                                      onChanged: (bool? newValue) {
                                        subPro.changRecord(newValue ?? false);
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  );
                                }),
                                SizedBox(height: 8.h),
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
                                SizedBox(height: 20.h),
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
