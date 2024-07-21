import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/UI/Widgets/close_table.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:provider/provider.dart';

class CloseMonth extends StatelessWidget {
  const CloseMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Consumer<OpProvider>(builder: (context, opPro, x) {
          return Form(
            key: opPro.formKey,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 122.w),
                            child: Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Consumer<OpProvider>(
                                        builder: (context, opPro, x) {
                                      return (opPro.month != null &&
                                              opPro.year != null)
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 120.w),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: MyButton(
                                                    text: 'إغلاق ملف',
                                                    onTap: opPro.onTapClose),
                                              ),
                                            )
                                          : const SizedBox();
                                    }),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                        height: 50.h,
                                        width: 90.w,
                                        child: Consumer<OpProvider>(
                                            builder: (context, opPro, x) {
                                          return DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            items: (opPro.years?.toList() ?? [])
                                                .map((type) => DropdownMenuItem(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      value: type,
                                                      child: Text(type),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              opPro.year = value;
                                              opPro.getOperationOfDate();
                                            },
                                            value: opPro.year,
                                            validator: opPro.yearValidet,
                                          );
                                        }),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'السنة',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                      width: 90.w,
                                      child: Consumer<OpProvider>(
                                          builder: (context, opPro, x) {
                                        return DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder()),
                                          items: (opPro.months?.toList() ?? [])
                                              .map((type) => DropdownMenuItem(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    value: type,
                                                    child: Text(type),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            opPro.month = value;
                                            opPro.getOperationOfDate();
                                          },
                                          value: opPro.month,
                                          validator: opPro.monthValidet,
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'الشهر',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          ': إختار الشهر المارد ترحيله',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Consumer<OpProvider>(builder: (context, opPro, x) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Card(
                                shape: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                elevation: 10,
                                child: SingleChildScrollView(
                                  child: CloseTable(
                                    operations: opPro.operations ?? [],
                                  ),
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
