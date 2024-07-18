import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/UI/Widgets/operationTable.dart';
import 'package:provider/provider.dart';

class ShowSubOperation extends StatelessWidget {
  const ShowSubOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OpProvider>(builder: (context, op, x) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: Text(
            op.subTitle ?? 'العمليات',
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
                              'جدول العمليات',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Card(
                              shape: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              elevation: 5,
                              child: SingleChildScrollView(
                                child: OperationTable(
                                  operations: op.subOperations ?? [],
                                ),
                              ),
                            ),
                          ),
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
    });
  }
}
