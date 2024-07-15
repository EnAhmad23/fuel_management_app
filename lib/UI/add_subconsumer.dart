import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
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
                                  child: Text(
                                    'المستهلك الرئيسي',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                  height: 10,
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
                                      value: subPro.hasRcord,
                                      onChanged: (bool? newValue) {
                                        subPro.changRecord(newValue ?? false);
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  );
                                }),
                                provider.hasRcord
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    ' التاريخ ',
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
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                  // textAlign: TextAlign.right,
                                                  controller: provider.dateCon,
                                                  // textDirection: TextDirection.rtl,
                                                  decoration: InputDecoration(
                                                      // alignLabelWithHint: true,
                                                      hintText:
                                                          provider.hintText,
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
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(2101),
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
                                                  fontSize: 16,
                                                  labelText: 'القراءة الاولية',
                                                  hintText:
                                                      'أدخل القراءة الأولية',
                                                  controller:
                                                      provider.recordCon))
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: 40),
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
