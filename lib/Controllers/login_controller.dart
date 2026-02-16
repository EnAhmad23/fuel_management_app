import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuel_management_app/models/DBModel.dart';
import 'package:fuel_management_app/models/user.dart';
import 'package:fuel_management_app/views/screens/home_page.dart';
import 'package:fuel_management_app/views/screens/login_page.dart';
import 'package:fuel_management_app/views/screens/admin/admin_home_page.dart';
import 'package:fuel_management_app/views/screens/trip_manager_home_page.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final DBModel _dbModel = DBModel();
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  User? currentUser;
  bool cheched = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
              id: e['id'] as int?,
              username: e['username'].toString(),
              password: '', // Don't store password in memory
              role: e['role']?.toString() ?? 'operation_manager');
        },
      ).toList();
      if (temp.isNotEmpty) {
        log('User logged in: ${temp.first?.username}, role: ${temp.first?.role}');
        return temp.first;
      }
    }
    return null;
  }

  login() async {
    if (!formKey.currentState!.validate()) return;

    _isLoading = true;
    update();

    try {
      User? user = await authCheck();
      if (user != null) {
        currentUser = user;
        _routeToHomePage(user.role);
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
    } finally {
      _isLoading = false;
      update();
    }
  }

  void _routeToHomePage(String? role) {
    switch (role) {
      case 'admin':
        Get.offAll(const AdminHomePage());
        break;
      case 'trip_manager':
        Get.offAll(const TripManagerHomePage());
        break;
      case 'operation_manager':
      default:
        Get.offAll(const HomePage());
        break;
    }
  }

  // Permission checks
  bool get isAdmin => currentUser?.role == 'admin';
  bool get isOperationManager => currentUser?.role == 'operation_manager';
  bool get isTripManager => currentUser?.role == 'trip_manager';

  bool get canManageOperations {
    return isAdmin || isOperationManager;
  }

  bool get canManageTrips {
    return isAdmin || isTripManager;
  }

  bool get canManageUsers {
    return isAdmin;
  }

  bool get canManageConsumers {
    return isAdmin || isOperationManager;
  }

  void logout() {
    currentUser = null;
    userName.clear();
    password.clear();
    Get.offAll(const LoginPage());
  }
}
