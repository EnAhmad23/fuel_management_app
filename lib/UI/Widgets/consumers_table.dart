import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/consumer.dart';
import 'package:fuel_management_app/UI/Widgets/setting_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../show_sub_of_con.dart';
import '../update_consumer.dart';

class ConsumersTable extends StatelessWidget {
  const ConsumersTable({super.key, required this.consumers});
  final List<AppConsumers> consumers;
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
            Consumer<DbProvider>(builder: (context, db, x) {
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
                                    child: Lottie.asset('assets/warning.json')),
                                SizedBox(
                                  height: 5.h,
                                ),
                                const Text('هل متاكد من حذف العنصر؟'),
                              ],
                            ),
                          ),
                          confirm: InkWell(
                            onTap: () {
                              db.deleteConsumer(consumer.id ?? 0);
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              padding: EdgeInsets.all(10.w),
                              child: const Text(
                                'نعم',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          cancel: InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5.r)),
                              padding: EdgeInsets.all(10.w),
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                      db.consumerNameController.text = '${consumer.name}';
                      db.setConsumer(consumer);
                      Get.to(const UpdateConsumer());
                    },
                    color: Colors.green,
                    icon: Icons.edit,
                    topRightRadius: 0,
                    iconColor: Colors.white,
                    topLiftRadius: 0,
                  ),
                  Consumer<SubProvider>(builder: (context, subPro, x) {
                    return SettingButton(
                        onTap: () {
                          db.setConsumer(consumer);
                          subPro.getSubConsumerOfCon(consumer.name);
                          Get.to(const ShowSubOfCon());
                        },
                        color: Colors.blue,
                        icon: Icons.remove_red_eye,
                        topRightRadius: 5.r,
                        topLiftRadius: 0,
                        iconColor: Colors.white);
                  }),
                ],
              );
            }),
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
