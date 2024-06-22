import 'package:flutter/material.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';

class SubonsumersTable extends StatelessWidget {
  const SubonsumersTable({super.key, required this.subconsumers});
  // ignore: non_constant_identifier_names
  final List<SubConsumerT> subconsumers;
  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: const TableBorder.symmetric(
        inside: BorderSide(color: Colors.grey),
        outside: BorderSide(color: Colors.grey),
      ),
      columns: const [
        DataColumn(label: Text('الإعدادات', textAlign: TextAlign.center)),
        DataColumn(
            label: Text('عدد عمليات الصرف', textAlign: TextAlign.center)),
        DataColumn(label: Text('وصف')),
        DataColumn(label: Text('المستهلك الرئيسي')),
        DataColumn(label: Text('المستهلك')),
        DataColumn(label: Text('#')),
      ],
      rows: subconsumers.map((subconsumer) {
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
          DataCell(Text('${subconsumer.numOfOP}')),
          DataCell(Text('${subconsumer.description}')),
          DataCell(Text('${subconsumer.consumerName}')),
          DataCell(Text('${subconsumer.details}')),
          DataCell(Text('${subconsumers.indexOf(subconsumer) + 1}')),
        ]);
      }).toList(),
    );
  }
}
