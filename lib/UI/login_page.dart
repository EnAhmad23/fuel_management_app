import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            const Icon(
              Icons.person,
              color: Colors.black,
              size: 200,
            ),
            Container(
              width: 500.w,
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        MyTextFormField(
                          labelText: 'إسم المستخدم',
                          hintText: 'ادخل إسم المستخدم ',
                        ),
                        SizedBox(height: 40.h),
                        MyTextFormField(
                          labelText: 'كلمة المرور',
                          obscureText: true,
                          hintText: 'أدخل كلمة المرور',
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
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
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
