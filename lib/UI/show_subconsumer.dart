import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:provider/provider.dart';

import 'Widgets/subconsumer_table.dart';

class ShowSubconsumer extends StatelessWidget {
  const ShowSubconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'المستهلكين الفرعيين',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
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
                        'جدول المستهلكين الفرعين',
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Card(
                        shape: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        elevation: 5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Consumer<SubProvider>(
                                  builder: (context, provider, x) {
                                return SubonsumersTable(
                                  subconsumers: provider.subconsumerT ?? [],
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
          ),
        ),
      ),
    );
  }
}
