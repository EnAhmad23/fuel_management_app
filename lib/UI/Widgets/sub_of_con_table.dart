import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';
import 'package:fuel_management_app/UI/Widgets/setting_button.dart';
import 'package:fuel_management_app/UI/show_sub_of_con.dart';
import 'package:fuel_management_app/UI/subconsumer_details.dart';
import 'package:fuel_management_app/UI/update_subconsumer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SubOfConTable extends StatelessWidget {
  const SubOfConTable({super.key, required this.subconsumers});
  // ignore: non_constant_identifier_names
  final List<SubConsumerT> subconsumers;
  @override
  Widget build(BuildContext context) {
    return DataTable(
      decoration: const BoxDecoration(color: Colors.white),
      border: const TableBorder.symmetric(
        inside: BorderSide(color: Colors.grey),
        outside: BorderSide(color: Colors.grey),
      ),
      columns: const [
        DataColumn(label: Text('الإعدادات', textAlign: TextAlign.center)),
        DataColumn(
            label: Text('عدد عمليات الصرف', textAlign: TextAlign.center)),
        DataColumn(label: Text('وصف إضافي')),
        DataColumn(label: Text('المستهلك الفرعي')),
        DataColumn(label: Text('#')),
      ],
      rows: subconsumers.map((subconsumer) {
        return DataRow(
          cells: [
            DataCell(
              Consumer<SubProvider>(builder: (context, subPro, x) {
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
                        subPro.deleteSubconsumer(subconsumer.id ?? 0);
                      },
                    ),
                    SettingButton(
                      onTap: () {
                        subPro.getConsumersNames();
                        subPro.setUpdatedSub(subconsumer);
                        subPro.subName.text = '${subconsumer.details}';
                        subPro.description.text = '${subconsumer.description}';
                        subPro.changeDropdownValue(subconsumer.consumerName);
                        subPro.changRecord(subconsumer.hasRecord == 1);

                        Get.to(const UpdateSubconsumer());
                      },
                      color: Colors.green,
                      icon: Icons.edit,
                      topRightRadius: 0,
                      iconColor: Colors.white,
                      topLiftRadius: 0,
                    ),
                    SettingButton(
                        onTap: () {
                          subPro.getAllSubOp(subconsumer.id);
                          Get.to(SubonsumerDetails(subConsumer: subconsumer));
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
            DataCell(Text('${subconsumer.numOfOP}')),
            DataCell(Text('${subconsumer.description}')),
            DataCell(Text('${subconsumer.details}')),
            DataCell(Text('${subconsumers.indexOf(subconsumer) + 1}')),
          ],
        );
      }).toList(),
    );
  }
}
