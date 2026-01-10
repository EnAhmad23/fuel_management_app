import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/trip_controller.dart';

class UpdateTrip extends StatelessWidget {
  const UpdateTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'تعديل رحلة',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 100.w),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: GetBuilder<TripController>(
                init: Get.find<TripController>(),
                builder: (trip) {
                  return Form(
                    key: trip.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                              ),
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyDropdown(
                                          lable: 'المستهلك الفرعي',
                                          itemsList: trip.subNames ?? [],
                                          onchanged: (value) {
                                            trip.setSubConName(value);
                                          },
                                          value: trip.subConName,
                                          validator: (p0) {
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: MyDropdown(
                                          lable: 'المستهلك الرئيسي',
                                          itemsList: trip.consumerNames ?? [],
                                          onchanged: (value) {
                                            trip.setConName(value);
                                            trip.getSubonsumersNames(
                                                trip.conName);
                                          },
                                          value: trip.conName,
                                          validator: trip.consumerValidator,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  MyTextFormField(
                                    validator: trip.roadValidator,
                                    labelText: 'وجهة الرحلة',
                                    hintText: 'أدخل وجهة الرحلة',
                                    controller: trip.roadCon,
                                  ),
                                  SizedBox(height: 20.h),
                                  MyTextFormField(
                                    labelText: 'سبب الرحلة',
                                    hintText: 'أدخل سبب الرحلة',
                                    controller: trip.reasonCon,
                                    validator: (p0) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          ' التاريخ ',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      TextFormField(
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(fontSize: 16.sp),
                                        controller: trip.dateCon,
                                        decoration: InputDecoration(
                                          hintText: trip.hintText,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                          suffixIcon: InkWell(
                                            child: Icon(Icons.calendar_today,
                                                color:
                                                    theme.colorScheme.primary),
                                            onTap: () async {
                                              var x = await showDatePicker(
                                                currentDate: trip.date,
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              trip.setDate(x);
                                            },
                                          ),
                                        ),
                                        readOnly: true,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  GetBuilder<TripController>(builder: (trip) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: MyButton(
                                        text: 'تعديل',
                                        onTap: trip.onTapUpdate,
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
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
