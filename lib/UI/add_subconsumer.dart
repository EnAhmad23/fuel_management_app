import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/UI/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/UI/Widgets/my_button.dart';

class AddSubconsumer extends StatelessWidget {
  const AddSubconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'إنشاء مستهلك فرعي',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 100.w),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Form(
                // key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.h,
                      color: Colors.blue,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('المستهلك الرئيسي',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            value: null,
                            onChanged: (String? newValue) {
                              // setState(() {
                              //   _selectedConsumer = newValue!;
                              // });
                            },
                            // items: _consumers.map<DropdownMenuItem<String>>((String value) {
                            //   return DropdownMenuItem<String>(
                            //     value: value,
                            //     child: Text(value),
                            //   );
                            // }).toList(),
                            // validator: (value) =>
                            //     value == null ? 'Please select a consumer' : null,
                            items: [],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // MyTextFormField(
                          //   labelText: 'اسم المستهلك',
                          //   hintText: 'أدخل اسم المستهلك',
                          // ),
                          // TextFormField(
                          //   // controller: _detailsController,
                          //   decoration: InputDecoration(
                          //     labelText: 'اسم المستهلك',
                          //     border: OutlineInputBorder(),
                          //   ),
                          //   // validator: (value) => value == null || value.isEmpty
                          //   //     ? 'Please enter details'
                          //   //     : null,
                          // ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // MyTextFormField(
                          //   labelText: 'تفاصيل المستهلك',
                          //   hintText: 'أدخل تفاصيل المستهلك',
                          // ),

                          // TextFormField(
                          //   // controller: _detailsController,
                          //   decoration: InputDecoration(
                          //     labelText: 'اسم المستهلك',
                          //     border: OutlineInputBorder(),
                          //   ),
                          //   // validator: (value) => value == null || value.isEmpty
                          //   //     ? 'Please enter details'
                          //   //     : null,
                          // ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CheckboxListTile(
                              title: Text(
                                'له عداد',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              // value: _hasRecord,
                              // onChanged:
                              //     (bool? newValue) {
                              //   setState(() {
                              //     _hasRecord = newValue!;
                              //   });
                              // }

                              controlAffinity: ListTileControlAffinity.leading,
                              value: false, onChanged: (bool? value) {},
                            ),
                          ),
                          SizedBox(height: 8.h),
                          const Align(
                            alignment: Alignment.centerRight,
                            // child: MyButton(text: 'إنشاء'),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 16.0.h),
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
