import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Model/consumer.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:fuel_management_app/UI/Widgets/sub_of_con_table.dart';
import 'package:fuel_management_app/UI/Widgets/subconsumer_table.dart';
import 'package:fuel_management_app/UI/add_subconsumer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Widgets/consumers_table.dart';

class ShowSubOfCon extends StatelessWidget {
  const ShowSubOfCon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(builder: (context, pro, x) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: Text(
            pro.consumer?.name ?? '',
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
                            child: Text(
                              'جدول ${pro.consumer?.name}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Column(
                            children: [
                              Consumer<DbProvider>(
                                  builder: (context, dbProvider, x) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Card(
                                    shape: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    elevation: 5,
                                    child: SingleChildScrollView(
                                      child: Consumer<SubProvider>(
                                          builder: (context, sub, x) {
                                        return SubOfConTable(
                                            subconsumers:
                                                sub.subconsumerOfCon ?? []);
                                      }),
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 30.h,
                              ),
                              Consumer<SubProvider>(builder: (context, sub, c) {
                                return MyButton(
                                  width: double.infinity,
                                  text: 'إضافة',
                                  onTap: () {
                                    sub.getConsumersNames();
                                    sub.changeDropdownValue(pro.consumer?.name);
                                    Get.to(const AddSubconsumer());
                                  },
                                );
                              })
                            ],
                          )
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
    });
  }
}
