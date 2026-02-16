import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/Controllers/sub_controller.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';

class UpdateSubconsumer extends StatelessWidget {
  const UpdateSubconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'مستهلك فرعي',
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
              child: GetBuilder<SubController>(
                init: Get.find<SubController>(),
                builder: (sub) {
                  return Form(
                    key: sub.formKey,
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
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'تعديل المتهللك الفرعي (${sub.subName.text})',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('المستهلك الرئيسي',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w800)),
                                  ),
                                  SizedBox(height: 15.h),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ),
                                    value: sub.dropdownValue,
                                    onChanged: (String? newValue) {
                                      sub.changeDropdownValue(newValue);
                                    },
                                    items: sub.consumersNames
                                        ?.map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        alignment: Alignment.centerRight,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    validator: sub.conNameValidtor,
                                  ),
                                  SizedBox(height: 20.h),
                                  MyTextFormField(
                                    validator: sub.subNameValidtor,
                                    labelText: 'اسم المستهلك',
                                    hintText: 'أدخل اسم المستهلك',
                                    controller: sub.subName,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(height: 20.h),
                                  MyTextFormField(
                                    labelText: 'تفاصيل المستهلك',
                                    hintText: 'أدخل تفاصيل المستهلك',
                                    controller: sub.subDescription,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(height: 20.h),
                                  GetBuilder<SubController>(builder: (sub) {
                                    return Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('له عداد',
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                            SizedBox(width: 10.w),
                                            Checkbox(
                                              value: sub.hasRcord,
                                              onChanged: (value) => sub
                                                  .changRecord(value ?? false),
                                            )
                                          ],
                                        ));
                                  }),
                                  SizedBox(height: 15.h),
                                  GetBuilder<SubController>(builder: (sub) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: MyButton(
                                        text: 'تعديل',
                                        onTap: sub.onTapUpdateSub,
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
