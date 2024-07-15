import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:fuel_management_app/UI/Widgets/operationTable.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'العمليات',
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
                                    operations: opPro.operations ?? []),
                              ),
                            ),
                          );
                        }),
                        Consumer<OpProvider>(builder: (context, pro, x) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 55),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    onPressed: () {
                                      pro.generatePdf(
                                          context, pro.operations ?? []);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.grey,
                                      backgroundColor: Colors
                                          .blueGrey[300], // Text and icon color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Rounded corners
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15), // Padding
                                    ),
                                    child: Text(
                                      'pdf تصدير ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.white),
                                    ))),
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
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
