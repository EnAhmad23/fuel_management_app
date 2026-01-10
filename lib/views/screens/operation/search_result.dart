import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/operationTable.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'العمليات',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(30.w),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetBuilder<OpController>(
                          init: Get.find<OpController>(),
                          builder: (pro) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 55.w),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pro.generatePdf(
                                        context, pro.operations ?? []);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    alignment: Alignment.centerRight,
                                    foregroundColor: Colors.white,
                                    backgroundColor: theme.colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 15.h),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('طباعة ',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.white)),
                                      const Icon(Icons.print,
                                          color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GetBuilder<OpController>(
                          init: Get.find<OpController>(),
                          builder: (opPro) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                elevation: 5,
                                child: SingleChildScrollView(
                                  child: OperationTable(
                                    operations: opPro.operations ?? [],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
