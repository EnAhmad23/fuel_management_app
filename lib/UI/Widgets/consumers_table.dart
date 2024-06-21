import 'package:flutter/material.dart';
import 'package:fuel_management_app/Model/consumer.dart';

class ConsumersTable extends StatelessWidget {
  const ConsumersTable({super.key, required this.consumers});
  final List<AppConsumers> consumers;
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
      rows: consumers.map((consumer) {
        return DataRow(cells: [
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    // Handle delete operation
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.green,
                  onPressed: () {
                    // Navigate to edit outcome or income
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  color: Colors.blue,
                  onPressed: () {
                    // Navigate to show outcome or income
                  },
                ),
              ],
            ),
          ),
          DataCell(
              Text('${consumer.operationsCount}', textAlign: TextAlign.center)),
          DataCell(Text('${consumer.subConsumerCount}',
              textAlign: TextAlign.center)),
          DataCell(Text(consumer.name ?? '', textAlign: TextAlign.center)),
          DataCell(Text('${consumers.indexOf(consumer) + 1}',
              textAlign: TextAlign.center)),
        ]);
      }).toList(),
    );
  }
}
