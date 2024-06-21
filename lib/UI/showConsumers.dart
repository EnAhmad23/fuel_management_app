import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Model/consumer.dart';
import 'package:provider/provider.dart';

import 'Widgets/consumers_table.dart';

class ShowConsumers extends StatelessWidget {
  const ShowConsumers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'المستهلكين الرئيسيين',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            'جدول المستهلكين الرئيسيين',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Consumer<DbProvider>(builder: (context, dbProvider, x) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Card(
                              shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              elevation: 5,
                              child: SingleChildScrollView(
                                child: ConsumersTable(
                                    consumers: dbProvider.consumers ??
                                        [
                                          AppConsumers(
                                              name: 'name',
                                              subConsumerCount: -1,
                                              operationsCount: -1,
                                              id: -1),
                                        ]),
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
