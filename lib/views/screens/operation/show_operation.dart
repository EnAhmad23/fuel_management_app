import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/operationTable.dart';

class ShowOperation extends StatelessWidget {
  const ShowOperation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'العمليات',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary, fontSize: 24.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: OperationTable(
                operations: Get.find<OpController>().operations ?? []),
          ),
        ),
      ),
    );
  }
}
