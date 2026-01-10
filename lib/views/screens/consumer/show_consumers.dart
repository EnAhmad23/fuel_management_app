import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/views/Widgets/consumers_table.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/db_controller.dart';
import 'package:fuel_management_app/models/consumer.dart';

class ShowConsumers extends StatelessWidget {
  const ShowConsumers({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'المستهلكين الرئيسيين',
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
                            'جدول المستهلكين الرئيسيين',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        GetBuilder<DbController>(
                          init: Get.find<DbController>(),
                          builder: (dbProvider) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                elevation: 5,
                                child: SingleChildScrollView(
                                  child: ConsumersTable(
                                    consumers: dbProvider.consumers ??
                                        [
                                          AppConsumers(
                                            name: 'name',
                                            subConsumerCount: -1,
                                            operationsCount: -1,
                                            id: -1,
                                          ),
                                        ],
                                  ),
                                ),
                              ),
                            );
                          },
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
  }
}
