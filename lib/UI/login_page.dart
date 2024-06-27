import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/login_provider.dart';
import 'package:fuel_management_app/Model/user.dart';
import 'package:fuel_management_app/UI/home_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Widgets/myTextFormField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.black,
              size: 200.sp,
            ),
            Container(
              width: 500.w,
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child:
                      Consumer<LoginProvider>(builder: (context, provider, x) {
                    return Form(
                      key: provider.formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          MyTextFormField(
                            labelText: 'إسم المستخدم',
                            hintText: 'ادخل إسم المستخدم ',
                            controller: provider.userName,
                            validator: provider.validUsername,
                          ),
                          SizedBox(height: 20.h),
                          MyTextFormField(
                            labelText: 'كلمة المرور',
                            obscureText: true,
                            hintText: 'أدخل كلمة المرور',
                            controller: provider.password,
                            validator: provider.validatePassword,
                          ),
                          SizedBox(height: 30.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                provider.login(context);
                              },
                              borderRadius: BorderRadius.circular(5.r),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5).r,
                                  color: const Color.fromARGB(255, 23, 23, 59),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
