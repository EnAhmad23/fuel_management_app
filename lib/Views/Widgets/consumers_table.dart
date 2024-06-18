import 'package:flutter/material.dart';
import 'package:fuel_management_app/Model/consumer.dart';

class ConsumersTable extends StatelessWidget {
  const ConsumersTable({super.key, required this.consumers});
  final List<Consumer> consumers;
  @override
  Widget build(BuildContext context) {
    return DataTable(
        border: const TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey),
          outside: BorderSide(color: Colors.grey),
        ),
        columns: const [
          DataColumn(label: Text('الإعدادات', textAlign: TextAlign.center)),
          DataColumn(label: Text('عدد العمليات', textAlign: TextAlign.center)),
          DataColumn(
              label:
                  Text('عدد المستهلكين الفرعيين', textAlign: TextAlign.center)),
          DataColumn(label: Text('المستهلك')),
          DataColumn(label: Text('#')),
        ],
        rows: []
        // consumers.map((consumer) {
        //   return DataRow(cells: [
        //     DataCell(Text('${operation.id}')),
        //     DataCell(Text(operation.subConsumerDetails)),
        //     DataCell(Text(operation.consumerName)),
        //     DataCell(Text(operation.receiverName)),
        //     DataCell(Text(operation.type, textAlign: TextAlign.center)),
        //     DataCell(Container(
        //       color: operation.checked ? Colors.red[700] : null,
        //       child: Text(
        //         operation.dischangeNumber,
        //         textAlign: TextAlign.center,
        //       ),
        //     )),
        //     DataCell(Text(operation.foulType, textAlign: TextAlign.center)),
        //     DataCell(Text('${operation.amount}', textAlign: TextAlign.center)),
        //     DataCell(Text(operation.newDate, textAlign: TextAlign.center)),
        //     DataCell(
        //       Row(
        //         children: [
        //           IconButton(
        //             icon: const Icon(Icons.remove_red_eye),
        //             color: Colors.blue,
        //             onPressed: () {
        //               // Navigate to show outcome or income
        //             },
        //           ),
        //           IconButton(
        //             icon: const Icon(Icons.edit),
        //             color: Colors.green,
        //             onPressed: () {
        //               // Navigate to edit outcome or income
        //             },
        //           ),
        //           IconButton(
        //             icon: const Icon(Icons.delete),
        //             color: Colors.red,
        //             onPressed: () {
        //               // Handle delete operation
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ]);
        // }).toList(),

        );
  }
}
