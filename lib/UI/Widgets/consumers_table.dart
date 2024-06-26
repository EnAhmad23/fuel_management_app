import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Model/consumer.dart';
import 'package:fuel_management_app/UI/Widgets/setting_button.dart';

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
            ButtonBar(
              buttonPadding: const EdgeInsets.all(0),
              mainAxisSize: MainAxisSize.min,
              children: [
                SettingButton(
                    color: Colors.red,
                    icon: Icons.delete,
                    topLiftRadius: 5.r,
                    topRightRadius: 0,
                    iconColor: Colors.white),
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
            ),
          ),
          DataCell(Center(
              child: Text('${consumer.operationsCount}',
                  textAlign: TextAlign.center))),
          DataCell(Center(
            child: Text('${consumer.subConsumerCount}',
                textAlign: TextAlign.center),
          )),
          DataCell(Center(
              child: Text(consumer.name ?? '', textAlign: TextAlign.center))),
          DataCell(Center(
            child: Text('${consumers.indexOf(consumer) + 1}',
                textAlign: TextAlign.center),
          )),
        ]);
      }).toList(),
    );
  }
}
