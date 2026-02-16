import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/models/DBModel.dart';
import 'package:fuel_management_app/views/Widgets/custom_snackbar.dart';

class UserManagementController extends GetxController {
  final DBModel _dbModel = DBModel();
  final CustomSnackBar mySnackBar = const CustomSnackBar();

  var users = <Map<String, Object?>>[].obs;
  var isLoading = true.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var selectedRole = 'operation_manager'.obs;

  final List<String> roles = [
    'admin',
    'operation_manager',
    'trip_manager',
  ];

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> loadUsers() async {
    isLoading.value = true;
    try {
      final loadedUsers = await _dbModel.getUsers();
      users.value = loadedUsers;
    } catch (e) {
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'خطأ',
        message: 'فشل في تحميل المستخدمين',
        lottieAssetPath: 'assets/json/close.json',
      ));
    } finally {
      isLoading.value = false;
    }
  }

  String getRoleDisplayName(String? role) {
    switch (role) {
      case 'admin':
        return 'مدير النظام';
      case 'operation_manager':
        return 'مدير العمليات';
      case 'trip_manager':
        return 'مدير الرحلات';
      default:
        return role ?? 'غير معروف';
    }
  }

  IconData getRoleIcon(String? role) {
    switch (role) {
      case 'admin':
        return Icons.admin_panel_settings_rounded;
      case 'operation_manager':
        return Icons.settings_rounded;
      case 'trip_manager':
        return Icons.emoji_transportation_rounded;
      default:
        return Icons.person_rounded;
    }
  }

  Color getRoleColor(String? role) {
    switch (role) {
      case 'admin':
        return Colors.red;
      case 'operation_manager':
        return Colors.blue;
      case 'trip_manager':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void resetForm() {
    usernameController.clear();
    passwordController.clear();
    selectedRole.value = 'operation_manager';
  }

  Future<void> addUser() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'خطأ',
        message: 'الرجاء إدخال اسم المستخدم وكلمة المرور',
        lottieAssetPath: 'assets/json/close.json',
      ));
      return;
    }

    try {
      await _dbModel.addUserWithRole(
        usernameController.text,
        passwordController.text,
        selectedRole.value,
      );
      Get.back();
      await loadUsers();
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'تم',
        message: 'تم إضافة المستخدم بنجاح',
      ));
    } catch (e) {
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'خطأ',
        message: 'فشل في إضافة المستخدم',
        lottieAssetPath: 'assets/json/close.json',
      ));
    }
  }

  Future<void> updateUser(int userId) async {
    try {
      await _dbModel.updateUser(
        userId,
        usernameController.text,
        selectedRole.value,
      );

      if (passwordController.text.isNotEmpty) {
        await _dbModel.updateUserPassword(
          userId,
          passwordController.text,
        );
      }

      Get.back();
      await loadUsers();
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'تم',
        message: 'تم تعديل المستخدم بنجاح',
      ));
    } catch (e) {
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'خطأ',
        message: 'فشل في تعديل المستخدم',
        lottieAssetPath: 'assets/json/close.json',
      ));
    }
  }

  Future<void> deleteUser(int userId, String username) async {
    if (username == 'admin') {
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'غير مسموح',
        message: 'لا يمكن حذف حساب المدير الرئيسي',
        lottieAssetPath: 'assets/json/close.json',
      ));
      return;
    }

    try {
      await _dbModel.deleteUser(userId);
      Get.back();
      await loadUsers();
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'تم',
        message: 'تم حذف المستخدم بنجاح',
      ));
    } catch (e) {
      Get.showSnackbar(mySnackBar.showSnackBar(
        title: 'خطأ',
        message: 'فشل في حذف المستخدم',
        lottieAssetPath: 'assets/json/close.json',
      ));
    }
  }
}
