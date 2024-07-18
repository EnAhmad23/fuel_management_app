import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:lottie/lottie.dart';

class CloseTable extends StatelessWidget {
  final List<OperationT> operations;

  const CloseTable({super.key, required this.operations});

  @override
  Widget build(BuildContext context) {
    log('operations $operations');
    return (operations.isEmpty)
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
                        child: Center(
                          child: Text(
                            operation.dischangeNumber ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.sp),
                          ),
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
