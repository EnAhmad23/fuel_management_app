import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:fuel_management_app/UI/Widgets/setting_button.dart';
import 'package:provider/provider.dart';

class OperationTable extends StatelessWidget {
  final List<OperationT> operations;
  const OperationTable({super.key, required this.operations});

  @override
  Widget build(BuildContext context) {
    log('operations $operations');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: const TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey),
          outside: BorderSide(color: Colors.grey),
        ),
        columns: const [
          DataColumn(
              label: Text(
            'الإعدادات',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          )),
          DataColumn(
              label: Center(
                  child: Text(
            'التاريخ',
            style: TextStyle(fontSize: 18),
          ))),
          DataColumn(
              label: Center(
                  child: Text(
            'الكمية',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ))),
          DataColumn(label: Text('نوع الوقود', textAlign: TextAlign.center)),
          DataColumn(
              label: SizedBox(
            child: Text('سند الصرف', textAlign: TextAlign.center),
            width: 80,
          )),
          DataColumn(label: Text('النوع', textAlign: TextAlign.center)),
          DataColumn(label: Text('اسم المستلم')),
          DataColumn(label: Text('المستهلك الأساسي')),
          DataColumn(label: Text('المستهلك')),
          DataColumn(label: Text('#')),
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
                          opPro.deleteOperation(operation.id ?? 0);
                        },
                      ),
                      const SettingButton(
                        color: Colors.green,
                        icon: Icons.edit,
                        topRightRadius: 0,
                        iconColor: Colors.white,
                        topLiftRadius: 0,
                      ),
                      SettingButton(
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
                  child: Text('${operation.formattedDate}',
                      textAlign: TextAlign.center))),
              DataCell(Center(
                  child: Text('${operation.amount}',
                      textAlign: TextAlign.center))),
              DataCell(
                  Text('${operation.foulType}', textAlign: TextAlign.center)),
              DataCell(
                Container(
                  width: 80,
                  height: 50,
                  color: operation.checked ?? false ? Colors.red[700] : null,
                  child: Text(
                    operation.dischangeNumber ?? '',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(Center(
                  child: Text(operation.type ?? '_',
                      textAlign: TextAlign.center))),
              DataCell(Center(child: Text(operation.receiverName ?? '_'))),
              DataCell(Center(child: Text(operation.consumerName ?? '_'))),
              DataCell(
                  Center(child: Text(operation.subConsumerDetails ?? '_'))),
              DataCell(
                  Center(child: Text('${operations.indexOf(operation) + 1}'))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
