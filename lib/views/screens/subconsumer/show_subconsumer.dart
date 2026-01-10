import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/views/Widgets/subconsumer_table.dart';

class ShowSubconsumer extends StatelessWidget {
  const ShowSubconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'المستهلكين الفرعيين',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
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
                        'جدول المستهلكين الفرعيين',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(color: theme.dividerColor),
                        ),
                        elevation: 5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              GetBuilder<SubController>(
                                init: Get.find<SubController>(),
                                builder: (sub) {
                                  return SubconsumerTable(
                                    subconsumers: sub.subconsumerT ?? [],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
