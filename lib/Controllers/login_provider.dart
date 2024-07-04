import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/user.dart';
import 'package:fuel_management_app/UI/home_page.dart';
import 'package:get/get.dart';

class LoginProvider extends ChangeNotifier {
  final DBModel _dbModel = DBModel();
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  User? user;
  bool cheched = false;
  Future<bool> checkUser(User user) async {
    return (await _dbModel.checkUser(user)) != null;
  }

  String? validUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال اسم المستخدم';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    return null;
  }

  Future<User?> authCheck() async {
    var re = await _dbModel
        .checkUser(User(username: userName.text, password: password.text));
    if (re.isNotEmpty) {
      List<User?> temp = re.map(
        (e) {
          return User(
              username: e['username'].toString(),
              password: e['password'].toString());
        },
      ).toList();
      if (temp.isNotEmpty) {
        log('${temp.first}');
        return temp.first;
      }
    }
    return null;
  }

  login(BuildContext con) async {
    if (formKey.currentState!.validate()) {
      User? user = await authCheck();
      if (user != null) {
        Navigator.of(con).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      } else {
        Get.snackbar(
          'خطأ',
          'خطأ في اسم المستخدم او كلمة المرور',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(Icons.error, color: Colors.white),
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }
}
