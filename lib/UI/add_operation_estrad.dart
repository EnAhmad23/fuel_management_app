import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:fuel_management_app/UI/Widgets/custom_switch.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddOperationEstrad extends StatelessWidget {
  const AddOperationEstrad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'إنشاء عملية استيراد جديدة',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 100.w),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Form(
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
                        child: Text('إنشاء عملية استيراد جديدة',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child:
                          Consumer<OpProvider>(builder: (context, provider, x) {
                        return Column(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '     التاريخ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        height: 50,
                                        child: TextFormField(
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
                                                  provider.date =
                                                      await showDatePicker(
                                                    currentDate: provider.date,
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                  );
                                                },
                                              )),
                                          readOnly: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(width: 10.w),
                                Expanded(
                                  child: MyTextFormField(
                                    labelText: 'الكمية',
                                    hintText: 'أدخل كمية الوقود',
                                    controller: TextEditingController(),
                                  ),
                                ),
                                SizedBox(width: 15.w),
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
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        value: 'بنزين',
                                        onChanged: (value) {},
                                        items: <String>['بنزين', 'سولار']
                                            .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            const CustomSwitch(),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        );
                      }),
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
                          Consumer<OpProvider>(builder: (context, provider, x) {
                            return TextField(
                              style: TextStyle(fontSize: 18.sp),
                              // textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              controller: provider.wasfCon,
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
                      height: 50.h,
                    ),
                    Consumer<OpProvider>(builder: (context, provider, x) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: MyButton(
                            text: 'إنشاء',
                            onTap: () {
                              provider.addOperationWared(
                                OperationT(
                                    subConsumerDetails: null,
                                    consumerName: null,
                                    receiverName: null,
                                    type: 'وارد',
                                    checked: provider.checked,
                                    dischangeNumber: null,
                                    foulType: provider.fuelType,
                                    amount: ((provider.amountCon.text) as num)
                                        .toDouble(),
                                    newDate: null,
                                    description: provider.wasfCon.text),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
