import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/models/subconsumerT.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/views/Widgets/info_box.dart';
import 'package:fuel_management_app/views/Widgets/movement_table.dart';
import 'package:fuel_management_app/views/Widgets/operationTable.dart';

class SubonsumerDetails extends StatelessWidget {
  const SubonsumerDetails({super.key, required this.subConsumer});
  final SubConsumerT subConsumer;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return GetBuilder<SubController>(
      init: Get.find<SubController>(),
      builder: (sub) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            centerTitle: true,
            elevation: 3,
            title: Text('المستهلك (${subConsumer.details})',
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.primary)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoBox(
                        title: 'المسافة المقطوعة بين آخر قراءتي عدّاد',
                        content: '${(sub.distance ?? 0) / 1000.0}  كيلو متر ',
                      ),
                      InfoBox(
                        title: 'المستهلك الرئيسي',
                        content: subConsumer.consumerName ?? '',
                      ),
                      InfoBox(
                        title: 'المستهلك',
                        content: subConsumer.details ?? '',
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  if ((sub.subOperations != null &&
                          sub.subOperations!.isNotEmpty) ||
                      subConsumer.description != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('التفاصيل',
                                style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary)),
                            Icon(Icons.draw_rounded,
                                color: theme.colorScheme.primary)
                          ],
                        ),
                        SizedBox(height: 16.h),
                        if (subConsumer.description != null)
                          Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: Text(subConsumer.description!,
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodyMedium),
                          ),
                        SizedBox(height: 16.h),
                        if (sub.subOperations != null &&
                            sub.subOperations!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('اخر العمليات',
                                          style: theme.textTheme.titleMedium),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        side: BorderSide(
                                            color: theme.dividerColor),
                                      ),
                                      elevation: 5,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            GetBuilder<SubController>(
                                                builder: (provider) {
                                              return OperationTable(
                                                operations:
                                                    provider.subOperations ??
                                                        [],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(height: 5.h),
                        if (sub.movementRecords != null &&
                            sub.movementRecords!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('جدول قراءات العداد',
                                          style: theme.textTheme.titleMedium),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        side: BorderSide(
                                            color: theme.dividerColor),
                                      ),
                                      elevation: 5,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            GetBuilder<SubController>(
                                                builder: (provider) {
                                              return MovementTable(
                                                movements:
                                                    provider.movementRecords ??
                                                        [],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
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
