import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/controllers/db_controller.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';
import 'package:fuel_management_app/views/Widgets/sub_of_con_table.dart';
import 'package:fuel_management_app/views/screens/subconsumer/add_subconsumer.dart';
import 'package:get/get.dart';

class ShowSubOfCon extends StatelessWidget {
  const ShowSubOfCon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return GetBuilder<DbController>(
      init: Get.find<DbController>(),
      builder: (pro) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            centerTitle: true,
            title: Text(
              pro.consumer?.name ?? '',
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.colorScheme.primary),
            ),
          ),
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.w),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                              child: Text(
                                'جدول ${pro.consumer?.name}',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Column(
                              children: [
                                GetBuilder<DbController>(
                                    init: Get.find<DbController>(),
                                    builder: (dbProvider) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            side: BorderSide(
                                                color: theme.dividerColor),
                                          ),
                                          elevation: 5,
                                          child: SingleChildScrollView(
                                            child: GetBuilder<SubController>(
                                                init: Get.find<SubController>(),
                                                builder: (sub) {
                                                  return SubOfConTable(
                                                      subconsumers:
                                                          sub.subconsumerOfCon ??
                                                              []);
                                                }),
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(height: 30.h),
                                GetBuilder<SubController>(
                                    init: Get.find<SubController>(),
                                    builder: (sub) {
                                      return MyButton(
                                        width: double.infinity,
                                        text: 'إضافة',
                                        onTap: () {
                                          sub.getConsumersNames();
                                          sub.changeDropdownValue(
                                              pro.consumer?.name);
                                          Get.to(const AddSubconsumer());
                                        },
                                      );
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
