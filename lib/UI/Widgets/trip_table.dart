import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:fuel_management_app/Model/trip.dart';
import 'package:fuel_management_app/UI/Widgets/setting_button.dart';
import 'package:fuel_management_app/UI/update_operation_sarf.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TripTable extends StatelessWidget {
  final List<Trip> trips;
  const TripTable({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    log('operations $trips');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        decoration: const BoxDecoration(color: Colors.white),
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
            'خيارات',
            style: TextStyle(fontSize: 18),
          ))),
          DataColumn(
              label: Center(
                  child: Text(
            'المسافة المقطوعة',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ))),
          DataColumn(label: Text('تاريخ الرحلة', textAlign: TextAlign.center)),
          DataColumn(
              label: SizedBox(
            child: Text('سبب الرحلة', textAlign: TextAlign.center),
            width: 80,
          )),
          DataColumn(
            label: Text('وجهة الرحلة', textAlign: TextAlign.center),
          ),
          DataColumn(label: Text('اسم المستهلك')),
          DataColumn(label: Text('#')),
        ],
        rows: trips.map((trip) {
          return DataRow(
            cells: [
              DataCell(ButtonBar(
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
                              // opPro.deleteOperation(operation.id ?? 0);
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
                      // opPro.checkOperationType(operation);
                    },
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
              )),
              DataCell(Center(
                  child: Text('${trip.status}', textAlign: TextAlign.center))),
              const DataCell(
                  Center(child: Text('0000', textAlign: TextAlign.center))),
              DataCell(Center(
                  child: Text('${trip.formattedDate}',
                      textAlign: TextAlign.center))),
              DataCell(Text('${trip.cause}', textAlign: TextAlign.center)),
              DataCell(Text('${trip.road}', textAlign: TextAlign.center)),
              DataCell(Center(
                  child: Text(trip.subconName ?? '_',
                      textAlign: TextAlign.center))),
              DataCell(Center(child: Text('${trips.indexOf(trip) + 1}'))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
