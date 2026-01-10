import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/views/Widgets/custom_switch.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';

class UpdateOperationEstrad extends StatelessWidget {
  const UpdateOperationEstrad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'تعديل عملية وارد',
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
            child: GetBuilder<OpController>(
              init: Get.find<OpController>(),
              builder: (op) {
                return Form(
                  key: op.formKey,
                  child: SingleChildScrollView(
                    child: GetBuilder<OpController>(
                        init: Get.find<OpController>(),
                        builder: (provider) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60.h,
                                color: Colors.blue,
                                width: double.infinity,
                                padding: const EdgeInsets.all(16.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('تعديل عملية وارد',
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
                                child: Column(
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
                                              validator: op.dateValidet,
                                              onTap: () async {
                                                var x = await showDatePicker(
                                                  currentDate: op.date,
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2101),
                                                );
                                                op.setDate(x);
                                              },
                                              style:
                                                  const TextStyle(fontSize: 16),
                                              // textAlign: TextAlign.right,

                                              controller: op.dateCon,
                                              // textDirection: TextDirection.rtl,
                                              decoration: InputDecoration(
                                                  // alignLabelWithHint: true,
                                                  hintText: op.hintText,
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
                                                        currentDate: op.date,
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2000),
                                                        lastDate:
                                                            DateTime(2101),
                                                      );
                                                      op.setDate(x);
                                                    },
                                                  )),
                                              readOnly: true,
                                            ),
                                          ],
                                        )),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: MyTextFormField(
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            fontSize: 16,
                                            validator: op.amontValidet,
                                            labelText: 'الكمية',
                                            hintText: 'أدخل كمية الوقود',
                                            controller: op.amountCon,
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
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
                                              op.setFuelType(value);
                                            } else {
                                              op.setFuelType(null);
                                            }
                                          },
                                          value:
                                              op.fuelType ?? 'اختر نوع الوقود',
                                          validator: op.fuelTypeValidator,
                                        ))
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
                                ),
                              ),
                              // 00
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
                                    GetBuilder<OpController>(
                                        builder: (provider) {
                                      return TextField(
                                        style: TextStyle(fontSize: 18.sp),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        controller: op.description,
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
                              GetBuilder<OpController>(builder: (op) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: MyButton(
                                      text: 'تعديل',
                                      onTap: op.onTopUpdateWared,
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
