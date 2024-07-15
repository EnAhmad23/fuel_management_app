import 'dart:developer';

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
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SubOfConTable extends StatelessWidget {
  const SubOfConTable({super.key, required this.subconsumers});
  // ignore: non_constant_identifier_names
  final List<SubConsumerT> subconsumers;
  @override
  Widget build(BuildContext context) {
    return (subconsumers == null || subconsumers.isEmpty)
        ? Center(
            child: SizedBox(
                height: 300.h,
                width: 600.h,
                child: Lottie.asset('assets/nodata.json')),
          )
        : DataTable(
            decoration: const BoxDecoration(color: Colors.white),
            border: const TableBorder.symmetric(
              inside: BorderSide(color: Colors.grey),
              outside: BorderSide(color: Colors.grey),
            ),
            columns: const [
              DataColumn(
                  label: Center(
                      child: Text(
                '    الإعدادات  ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ))),
              DataColumn(
                  label: Center(
                      child: Text(
                'عدد عمليات الصرف',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ))),
              DataColumn(
                  label: Center(
                      child: Text(
                'وصف إضافي',
                style: TextStyle(fontSize: 18),
              ))),
              DataColumn(
                  label: Center(
                      child: Text(
                'المستهلك الفرعي',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ))),
              DataColumn(label: Center(child: Text('#'))),
            ],
            rows: subconsumers.map((subconsumer) {
              return DataRow(
                cells: [
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 0),
                      child:
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
                                    confirm: InkWell(
                                      onTap: () {
                                        subPro.deleteSubconsumer(
                                            subconsumer.id ?? 0);
                                        subPro.getSubConsumerOfCon(
                                            subconsumer.consumerName);
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
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
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
                                subPro.getConsumersNames();
                                subPro.setUpdatedSub(subconsumer);
                                subPro.subName.text = '${subconsumer.details}';
                                subPro.description.text =
                                    '${subconsumer.description}';
                                subPro.changeDropdownValue(
                                    subconsumer.consumerName);
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
                                onTap: () async {
                                  subPro.id = subconsumer.id;
                                  subPro.getMovementRecord(subconsumer.id ?? 0);
                                  subPro.getAllSubOp(subconsumer.id);
                                  log('Consuer Name -> ${subconsumer.consumerName}');
                                  log('Consuer Name -> ${subconsumer.details}');
                                  await subPro.getDistanceBetweenLastTwoRecords(
                                      subconsumer.id ?? 0);
                                  Get.to(SubonsumerDetails(
                                      subConsumer: subconsumer));
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
                  ),
                  DataCell(Center(
                    child: Text(
                      '${subconsumer.numOfOP}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${subconsumer.description}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${subconsumer.details}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${subconsumers.indexOf(subconsumer) + 1}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  )),
                ],
              );
            }).toList(),
          );
  }
}
