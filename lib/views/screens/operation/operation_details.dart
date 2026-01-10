import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/models/operationT.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/views/Widgets/info_box.dart';

class OperationDetails extends StatelessWidget {
  const OperationDetails({super.key, required this.operationT});
  final OperationT operationT;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<OpController>(
      init: Get.find<OpController>(),
      builder: (opPro) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            centerTitle: true,
            elevation: 3,
            title: Text('العملية',
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.primary)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoBox(
                        title: 'نوع الوقود',
                        content: '${(operationT.foulType)} ',
                      ),
                      InfoBox(
                        title: 'الكمية',
                        content: '${operationT.amount}',
                      ),
                      InfoBox(
                        title: 'التاريخ',
                        content: '${operationT.formattedDate}',
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'التفاصيل',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Icon(Icons.draw_rounded,
                              color: theme.colorScheme.primary)
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (operationT.dischangeNumber != null &&
                                  operationT.dischangeNumber != '_')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('رقم سند الصرف',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: Colors.grey,
                                                fontSize: 18.sp)),
                                    Text('${operationT.dischangeNumber}#',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(height: 10.h),
                          (operationT.receiverName != null &&
                                  operationT.receiverName != '_')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('اسم المستلم',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: Colors.grey,
                                                fontSize: 18.sp)),
                                    Text(operationT.receiverName ?? '',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(height: 10.h),
                          (operationT.consumerName != null &&
                                  operationT.consumerName != '_')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('المستهلك الاساسي',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: Colors.grey,
                                                fontSize: 18.sp)),
                                    Text(operationT.consumerName ?? '',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(height: 10.h),
                          (operationT.subConsumerDetails != null &&
                                  operationT.subConsumerDetails != '_')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('المستهلك الفرعي',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: Colors.grey,
                                                fontSize: 18.sp)),
                                    Text(operationT.subConsumerDetails!,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(height: 15.h),
                          (operationT.description != null &&
                                  operationT.description != '')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('الوصف',
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                    Text(operationT.description!,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'حذف',
                                    backgroundColor: theme.colorScheme.surface,
                                    content: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: 100.h,
                                              width: 200.h,
                                              child: Lottie.asset(
                                                  'assets/warning.json')),
                                          SizedBox(height: 5.h),
                                          Text('هل متاكد من حذف العنصر؟',
                                              style:
                                                  theme.textTheme.bodyMedium),
                                        ],
                                      ),
                                    ),
                                    confirm: GetBuilder<SubController>(
                                        init: Get.find<SubController>(),
                                        builder: (subPro) {
                                          return InkWell(
                                            onTap: () {
                                              opPro.deleteOperation(
                                                  operationT.id!);
                                              subPro
                                                  .getAllSubOp(operationT.id!);
                                              opPro.getAllOpT();
                                              Get.back();
                                              Get.back();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r)),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              padding: EdgeInsets.all(10.w),
                                              child: Text('نعم',
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.white)),
                                            ),
                                          );
                                        }),
                                    cancel: InkWell(
                                      onTap: () => Get.back(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5.r)),
                                        padding: EdgeInsets.all(10.w),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Text('لا',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                ),
                                child: Row(
                                  children: [
                                    Text('حذف',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.white)),
                                    const Icon(Icons.delete,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  onPressed: () {
                                    opPro.checkOperationType(operationT);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: theme.colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 8.h),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('تعديل',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.white)),
                                      const Icon(Icons.edit,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
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
