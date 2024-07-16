import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/UI/Widgets/custom_switch.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:provider/provider.dart';

class UpdateSubconsumer extends StatelessWidget {
  const UpdateSubconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'مستهلك فرعي',
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
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'تعديل المتهلك الفرعي (${provider.subName.text})',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('المستهلك الرئيسي',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w800)),
                                ),
                                const SizedBox(
                                  height: 15,
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
                                const SizedBox(
                                  height: 20,
                                ),
                                MyTextFormField(
                                  validator: provider.subNameValidtor,
                                  labelText: 'اسم المستهلك',
                                  hintText: 'أدخل اسم المستهلك',
                                  controller: provider.subName,
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MyTextFormField(
                                  labelText: 'تفاصيل المستهلك',
                                  hintText: 'أدخل تفاصيل المستهلك',
                                  controller: provider.subDescription,
                                  fontSize: 16,
                                  // validator: provider.descriptionValidtor,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Consumer<SubProvider>(
                                    builder: (context, subPro, x) {
                                  return Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end, // Aligning the row to the start
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'له عداد',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      fontWeight: FontWeight
                                                          .bold), // Customize the style as needed
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Checkbox(
                                            value: subPro.hasRcord,
                                            onChanged: (value) => provider
                                                .changRecord(value ?? false),
                                          )
                                        ],
                                      ));
                                }),
                                SizedBox(
                                  height: 15,
                                ),
                                Consumer<SubProvider>(
                                    builder: (context, subPr, x) {
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: MyButton(
                                      text: 'تعديل',
                                      onTap: provider.onTapUpdateSub,
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
