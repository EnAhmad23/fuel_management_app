import 'package:flutter/material.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';
import 'package:fuel_management_app/UI/Widgets/operationTable.dart';
import 'package:provider/provider.dart';

class SubonsumerDetails extends StatelessWidget {
  const SubonsumerDetails({super.key, required this.subConsumer});
  final SubConsumerT subConsumer;

  @override
  Widget build(BuildContext context) {
    return Consumer<SubProvider>(builder: (context, sub, x) {
      return Scaffold(
        appBar: AppBar(
          title: Text('المستهلك (${subConsumer?.details})'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoBox(
                      title: 'المستهلك',
                      content: subConsumer.details ?? '',
                    ),
                    InfoBox(
                      title: 'المستهلك الرئيسي',
                      content: subConsumer.consumerName ?? '',
                    ),
                    InfoBox(
                        title: 'المسافة المقطوعة بين آخر قراءتي عدّاد',
                        content: '' // '${sub.get.} كيلو متر',
                        ),
                  ],
                ),

                const SizedBox(height: 16.0),

                // Operations section
                if (sub.subOperations!.isNotEmpty ||
                    // movementRecords.isNotEmpty ||
                    subConsumer.description != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'التفاصيل',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
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
                      if (sub.subOperations!.isNotEmpty)
                        Card(
                          child: OperationTable(
                              operations: sub.subOperations ?? []),
                        ),

                      const SizedBox(height: 16.0),

                      // Movement records table
                      // if (movementRecords.isNotEmpty)
                      //   Card(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.stretch,
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsets.all(16.0),
                      //           child: Text(
                      //             'جدول قراءات العدّاد',
                      //             style: TextStyle(
                      //               fontSize: 18.0,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ),
                      //         DataTable(
                      //           columns: [
                      //             DataColumn(label: Text('#')),
                      //             DataColumn(label: Text('قراءة العدّاد')),
                      //             DataColumn(label: Text('التاريخ')),
                      //           ],
                      //           rows: List.generate(
                      //             movementRecords.length,
                      //                 (index) => DataRow(
                      //               cells: [
                      //                 DataCell(Text('${index + 1}')),
                      //                 DataCell(Text('${movementRecords[index].record}')),
                      //                 DataCell(Text(movementRecords[index].date)),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
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

class InfoBox extends StatelessWidget {
  final String title;
  final String content;

  InfoBox({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                content,
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
