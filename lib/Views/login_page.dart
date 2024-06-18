import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                        TextFormField(
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(
                              'إسم المستخدم',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 40.h),
                        TextFormField(
                          style: TextStyle(fontSize: 18.sp),
                          obscureText: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: Text(
                              'كلمة المرور',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
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
