import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Model/movement.dart';
import 'package:fuel_management_app/UI/Widgets/setting_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Controllers/sub_provider.dart';

class MovementTable extends StatelessWidget {
  final List<Movement> movements;
  const MovementTable({super.key, required this.movements});

  @override
  Widget build(BuildContext context) {
    log('operations $movements');
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
            'التاريخ',
            style: TextStyle(fontSize: 18),
          ))),
          DataColumn(label: Text('قراءة العداد', textAlign: TextAlign.center)),
          DataColumn(label: Text('#')),
        ],
        rows: movements.map((movement) {
          return DataRow(
            cells: [
              DataCell(
                Consumer<SubProvider>(builder: (context, subPro, x) {
                  return Center(
                    child: SettingButton(
                      color: Colors.red,
                      icon: Icons.delete,
                      topLiftRadius: 5.r,
                      topRightRadius: 5.r,
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
                                      child:
                                          Lottie.asset('assets/warning.json')),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  const Text('هل متاكد من حذف العنصر؟'),
                                ],
                              ),
                            ),
                            confirm: InkWell(
                              onTap: () {
                                subPro.deleteMovement(
                                    movement.id, movement.subId ?? 0);
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
                  );
                }),
              ),
              DataCell(Center(
                  child: Text('${movement.formattedDate}',
                      textAlign: TextAlign.center))),
              DataCell(Center(child: Text('${movement.record}'))),
              DataCell(
                  Center(child: Text('${movements.indexOf(movement) + 1}'))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
