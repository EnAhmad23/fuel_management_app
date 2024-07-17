import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/UI/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/UI/Widgets/operationTable.dart';
import 'package:provider/provider.dart';

class CloseMonth extends StatelessWidget {
  const CloseMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'إغلاق شهر',
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
                            'جدول عمليات الشهر',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Consumer<OpProvider>(
                                  builder: (context, opPro, x) {
                                return Expanded(
                                  child: MyDropdown(
                                    lable: 'السنة',
                                    itemsList: opPro.years ?? [],
                                    onchanged: (value) {
                                      opPro.year = value;
                                    },
                                    value: opPro.year,
                                    validator: (p0) {
                                      return null;
                                    },
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              width: 100,
                              child: Consumer<OpProvider>(
                                  builder: (context, opPro, x) {
                                return Expanded(
                                  child: MyDropdown(
                                    lable: 'الشهر',
                                    itemsList: opPro.months ?? [],
                                    onchanged: (value) {
                                      opPro.month = value;
                                    },
                                    value: opPro.month,
                                    validator: (p0) {
                                      return null;
                                    },
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                        Consumer<OpProvider>(builder: (context, opPro, x) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Card(
                              shape: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              elevation: 5,
                              child: SingleChildScrollView(
                                child: OperationTable(
                                  operations: opPro.operations ?? [],
                                  edit: false,
                                ),
                              ),
                            ),
                          );
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
    );
  }
}
