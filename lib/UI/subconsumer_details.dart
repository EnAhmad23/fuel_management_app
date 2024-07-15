import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';
import 'package:fuel_management_app/UI/Widgets/info_box.dart';
import 'package:fuel_management_app/UI/Widgets/movement_table.dart';
import 'package:fuel_management_app/UI/Widgets/operationTable.dart';
import 'package:provider/provider.dart';

class SubonsumerDetails extends StatelessWidget {
  const SubonsumerDetails({super.key, required this.subConsumer});
  final SubConsumerT subConsumer;

  @override
  Widget build(BuildContext context) {
    return Consumer<SubProvider>(builder: (context, sub, x) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 3,
          title: Text('المستهلك (${subConsumer.details})'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoBox(
                      title: 'المسافة المقطوعة بين آخر قراءتي عدّاد',
                      content: '${(sub.distance ?? 0) / 1000.0}  كيلو متر ',
                    ),
                    InfoBox(
                      title: 'المستهلك الرئيسي',
                      content: subConsumer.consumerName ?? '',
                    ),
                    InfoBox(
                      title: 'المستهلك',
                      content: subConsumer.details ?? '',
                    ),
                  ],
                ),

                SizedBox(height: 16.0.h),

                // Operations section
                if ((sub.subOperations != null &&
                        sub.subOperations!.isNotEmpty) ||
                    // movementRecords.isNotEmpty ||
                    subConsumer.description != null)
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

                      // Description
                      if (subConsumer.description != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            subConsumer.description!,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      const SizedBox(height: 16.0),

                      // Operations table
                      if (sub.subOperations != null &&
                          sub.subOperations!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Card(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.w,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('اخر العمليات'),
                                  ),
                                ),
                                // Divider(
                                //   color: Colors.black,
                                //   thickness: 1.2.w,
                                // ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Card(
                                    shape: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    elevation: 5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Consumer<SubProvider>(
                                              builder: (context, provider, x) {
                                            return OperationTable(
                                                operations:
                                                    provider.subOperations ??
                                                        []);
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 5.0),

                      // Movement records table
                      if (sub.movementRecords != null &&
                          sub.movementRecords!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Card(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.w,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('جدول قراءات العداد'),
                                  ),
                                ),
                                // Divider(
                                //   color: Colors.black,
                                //   thickness: 1.2.w,
                                // ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Card(
                                    shape: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    elevation: 5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Consumer<SubProvider>(
                                              builder: (context, provider, x) {
                                            return MovementTable(
                                                movements:
                                                    provider.movementRecords ??
                                                        []);
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
