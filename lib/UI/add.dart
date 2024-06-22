import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';
import 'package:provider/provider.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'إنشاء مستهلك',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 400.h,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Consumer<DbProvider>(builder: (context, dbprovider, x) {
                return Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.blue,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'إنشاء مستهلك جديد',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: MyTextFormField(
                          controller: dbprovider.consumerNameController,
                          labelText: 'اسم المستهلك',
                          hintText: 'أدخل اسم المستهلك',
                        ),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     labelText: 'اسم المستهلك',
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'الرجاء إدخال اسم المستهلك';
                        //     }
                        //     return null;
                        //   },
                        // ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MyButton(
                          text: 'إنشاء',
                          onTap: () {
                            dbprovider.addConsumer(
                                dbprovider.consumerNameController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
