import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:fuel_management_app/UI/Widgets/setting_button.dart';
import 'package:fuel_management_app/UI/operation_details.dart';
import 'package:fuel_management_app/UI/update_operation_sarf.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OperationTable extends StatelessWidget {
  final List<OperationT> operations;
  const OperationTable({super.key, required this.operations});

  @override
  Widget build(BuildContext context) {
    log('operations $operations');
    return (operations == null || operations.length == 0)
        ? Center(
            child: SizedBox(
                height: 300.h,
                width: 600.h,
                child: Lottie.asset('assets/nodata.json')),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              decoration: const BoxDecoration(color: Colors.white),
              border: const TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey),
                outside: BorderSide(color: Colors.grey),
              ),
              columns: const [
                DataColumn(
                    label: SizedBox(
                  width: 110,
                  child: Center(
                    child: Text(
                      'الإعدادات',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )),
                DataColumn(
                    label: SizedBox(
                  width: 80,
                  child: Center(
                      child: Text(
                    textAlign: TextAlign.center,
                    'التاريخ',
                    style: TextStyle(fontSize: 18),
                  )),
                )),
                DataColumn(
                    label: Center(
                        child: Text(
                  'الكمية',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ))),
                DataColumn(
                    label: Center(
                        child: Text(
                  'نوع الوقود',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ))),
                DataColumn(
                    label: Center(
                  child: SizedBox(
                    width: 87,
                    child: Text(
                      'سند الصرف',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )),
                DataColumn(
                    label: Text(
                  'النوع',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(
                    label: Text(
                  'اسم المستلم',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  'المستهلك الأساسي',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  'المستهلك',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  '#',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )),
              ],
              rows: operations.map((operation) {
                return DataRow(
                  cells: [
                    DataCell(
                      Consumer<OpProvider>(builder: (context, opPro, x) {
                        return ButtonBar(
                          buttonPadding: const EdgeInsets.all(0),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SettingButton(
                              color: Colors.red,
                              icon: Icons.delete,
                              topLiftRadius: 5.r,
                              topRightRadius: 0,
                              iconColor: Colors.white,
                              onTap: () {
                                Get.defaultDialog(
                                    title: 'حذف',
                                    backgroundColor: Colors.white,
                                    content: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: 100.h,
                                              width: 200.h,
                                              child: Lottie.asset(
                                                  'assets/warning.json')),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          const Text('هل متاكد من حذف العنصر؟'),
                                        ],
                                      ),
                                    ),
                                    confirm: Consumer<SubProvider>(
                                        builder: (context, sub, x) {
                                      return InkWell(
                                        onTap: () {
                                          opPro.deleteOperation(
                                              operation.id ?? 0);
                                          sub.getAllSubOp(sub.id);
                                          Get.back();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          padding: EdgeInsets.all(10.w),
                                          child: const Text(
                                            'نعم',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
                                        child: const Text(
                                          'لا',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                            SettingButton(
                              onTap: () {
                                opPro.checkOperationType(operation);
                              },
                              color: Colors.green,
                              icon: Icons.edit,
                              topRightRadius: 0,
                              iconColor: Colors.white,
                              topLiftRadius: 0,
                            ),
                            SettingButton(
                                onTap: () {
                                  Get.to(
                                      OperationDetails(operationT: operation));
                                },
                                color: Colors.blue,
                                icon: Icons.remove_red_eye,
                                topRightRadius: 5.r,
                                topLiftRadius: 0,
                                iconColor: Colors.white),
                          ],
                        );
                      }),
                    ),
                    DataCell(Center(
                        child: Text(
                      '${operation.formattedDate}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp),
                    ))),
                    DataCell(Center(
                        child: Text(
                      '${operation.amount}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp),
                    ))),
                    DataCell(Center(
                      child: Text(
                        '${operation.foulType}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    )),
                    DataCell(
                      Container(
                        width: 80,
                        height: 50,
                        color:
                            operation.checked ?? false ? Colors.red[700] : null,
                        child: Text(
                          operation.dischangeNumber ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    DataCell(Center(
                        child: Text(
                      operation.type ?? '_',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp),
                    ))),
                    DataCell(Center(
                        child: Text(
                      operation.receiverName ?? '_',
                      style: const TextStyle(fontSize: 16),
                    ))),
                    DataCell(Center(
                        child: Text(
                      operation.consumerName ?? '_',
                      style: TextStyle(fontSize: 16.sp),
                    ))),
                    DataCell(Center(
                        child: Text(
                      operation.subConsumerDetails ?? '_',
                      style: TextStyle(fontSize: 16.sp),
                    ))),
                    DataCell(Center(
                        child: Text(
                      '${operations.indexOf(operation) + 1}',
                      style: TextStyle(fontSize: 16.sp),
                    ))),
                  ],
                );
              }).toList(),
            ),
          );
  }
}
