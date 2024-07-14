import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';
import 'package:fuel_management_app/UI/Widgets/movement_table.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:fuel_management_app/UI/Widgets/operationTable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Controllers/op_provider.dart';
import 'Widgets/info_box.dart';

class OperationDetails extends StatelessWidget {
  const OperationDetails({super.key, required this.operationT});
  final OperationT operationT;

  @override
  Widget build(BuildContext context) {
    return Consumer<OpProvider>(builder: (context, opPro, x) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 3,
          title: const Text('العملية'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoBox(
                      title: 'نوع الوقود',
                      content: '${(operationT.foulType)} ',
                    ),
                    InfoBox(
                      title: 'الكمية',
                      content: '${operationT.amount}',
                    ),
                    InfoBox(
                      title: 'التاريخ',
                      content: '${operationT.formattedDate}',
                    ),
                  ],
                ),

                SizedBox(height: 16.0.h),

                // Operations section

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'التفاصيل',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Icon(
                          Icons.draw_rounded,
                          color: Colors.blue,
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'رقم سند الصرف',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        Text(
                          '${operationT.amount}#',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'اسم المستلم',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        Text(
                          operationT.receiverName ?? '',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'المستهلك الاساسي',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        Text(
                          operationT.consumerName ?? '',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'المستهلك الفرعي',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        Text(
                          operationT.subConsumerDetails ?? '',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'الوصف',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          operationT.description ?? '_',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        // const Text(
                        //   'المختصر',
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
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
                                    confirm: Consumer<SubProvider>(
                                        builder: (context, sub, x) {
                                      return InkWell(
                                        onTap: () {
                                          opPro.deleteOperation(
                                              operationT.id ?? 0);
                                          sub.getAllSubOp(sub.id);
                                          opPro.getAllOpT();
                                          Get.back();
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }),
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
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.red, // Text and icon color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8), // Padding
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'حذف',
                                  ),
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                opPro.checkOperationType(operationT);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.blue, // Text and icon color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8), // Padding
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'تعديل',
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
