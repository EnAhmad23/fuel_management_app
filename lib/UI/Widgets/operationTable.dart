import 'package:flutter/material.dart';
import 'package:fuel_management_app/Model/operationT.dart';

class OperationTable extends StatelessWidget {
  const OperationTable({super.key, required this.operations});
  final List<OperationT> operations;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: const TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey),
          outside: BorderSide(color: Colors.grey),
        ),
        columns: const [
          DataColumn(label: Text('الإعدادات', textAlign: TextAlign.center)),
          DataColumn(label: Text('التاريخ', textAlign: TextAlign.center)),
          DataColumn(label: Text('الكمية', textAlign: TextAlign.center)),
          DataColumn(label: Text('نوع الوقود', textAlign: TextAlign.center)),
          DataColumn(label: Text('سند الصرف', textAlign: TextAlign.center)),
          DataColumn(label: Text('النوع', textAlign: TextAlign.center)),
          DataColumn(label: Text('اسم المستلم')),
          DataColumn(label: Text('المستهلك الأساسي')),
          DataColumn(label: Text('المستهلك')),
          DataColumn(label: Text('#')),
        ],
        rows: operations.map((operation) {
          return DataRow(cells: [
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      color: Colors.blue,
                      onPressed: () {
                        // Navigate to show outcome or income
                      },
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.green,
                      onPressed: () {
                        // Navigate to edit outcome or income
                      },
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        // Handle delete operation
                      },
                    ),
                  ),
                ],
              ),
            ),
            DataCell(Text('${operation.newDate}', textAlign: TextAlign.center)),
            DataCell(Text('${operation.amount}', textAlign: TextAlign.center)),
            DataCell(
                Text(operation.foulType ?? '_', textAlign: TextAlign.center)),
            DataCell(Container(
              color: operation.checked ?? false ? Colors.red[700] : null,
              child: Text(
                operation.dischangeNumber ?? '_',
                textAlign: TextAlign.center,
              ),
            )),
            DataCell(Text(operation.type ?? '_', textAlign: TextAlign.center)),
            DataCell(Text(operation.receiverName ?? '_')),
            DataCell(Text(operation.consumerName ?? '_')),
            DataCell(Text(operation.subConsumerDetails ?? '_')),
            DataCell(Text('${operations.indexOf(operation) + 1}')),
          ]);
        }).toList(),
      ),
    );
  }
}
