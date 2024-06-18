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
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'إسم المستخدم',
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'كلمة المرور',
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
                              color: const Color.fromARGB(255, 9, 5, 116),
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
          ],
        ),
      ),
    );
  }
}
