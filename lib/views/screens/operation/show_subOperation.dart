import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/operationTable.dart';

class ShowSubOperation extends StatelessWidget {
  const ShowSubOperation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<OpController>(
      init: Get.find<OpController>(),
      builder: (opPro) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            centerTitle: true,
            title: Text(
              opPro.subTitle ?? 'العمليات',
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
                                'جدول العمليات',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                elevation: 5,
                                child: SingleChildScrollView(
                                  child: OperationTable(
                                    operations: opPro.subOperations ?? [],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
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
