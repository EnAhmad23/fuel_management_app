import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_management_app/models/DBModel.dart';
import 'package:fuel_management_app/models/consumer.dart';
import 'package:fuel_management_app/models/subconsumer.dart';
import 'package:fuel_management_app/views/Widgets/custom_snackbar.dart';

import '../models/operationT.dart';
// ignore: unused_import
import '../models/subconsumerT.dart';
import 'package:get/get.dart';

class DbController extends GetxController {
  // Database? database;
  final DBModel _dbModel = DBModel();
  int? numOfOp;
  int? numOfSub;
  DbController() {
    getNumOfSubconsumers();
  }
  // Operation? operation;
  AppConsumers? _consumer;
  GlobalKey<FormState> formKey = GlobalKey();
  List<AppConsumers>? consumers;
  List<OperationT>? operations;
  List<String>? consumersNames;
  CustomSnackBar mySnackBar = const CustomSnackBar();
  AppConsumers? get consumer {
    return _consumer;
  }

  void setConsumer(AppConsumers con) {
    _consumer = con;
    update();
  }

  TextEditingController consumerNameController = TextEditingController();
  // DbProvider() {
  //   initDB();
  // }
  // initDB() async {
  //   database = await _dbModel.db;
  // }
  String? nameValidtor(String? value) {
    if (value == null || value.isEmpty) {
      return 'أدخل اسم المستهلك';
    }
    return null;
  }

  Future<List<AppConsumers>?> getConsumerForTable() async {
    try {
      List<Map<String, Object?>> re = await _dbModel.getConsumerForTable();
      List<AppConsumers>? temp = re.map(
        (e) {
          return AppConsumers(
            name: e['consumer_name']?.toString() ?? '',
            subConsumerCount:
                int.tryParse(e['number_of_subconsumers']?.toString() ?? '0') ??
                    0,
            operationsCount:
                int.tryParse(e['number_of_operations']?.toString() ?? '0'),
            id: int.tryParse(e['consumer_id']?.toString() ?? '0'),
          );
        },
      ).toList();
      log('The length ${temp.length}');
      consumers = temp;
      update();
      return consumers;
    } catch (e) {
      log('Error fetching data: $e');
      return null;
    }
  }

  getNumOfOp(int subconsumerId) async {
    int? temp = await _dbModel.getNumOfOp(subconsumerId);
    numOfOp = temp;
    update();
    log('numOfOp = $numOfOp');
  }

  void getNumOfSubconsumers() async {
    numOfSub = await _dbModel.getNumOfSubconsumers() ?? 0;
    log('Number of Subconsumers -> $numOfSub');
    update();
  }

  // Future<List<SubConsumerT>?> getSubConsumerT() async {
  //   List<Map<String, Object?>> re = await _dbModel.getSubconsumerForTable();
  //   List<SubConsumerT>? temp = re
  //       .map(
  //         (e) => SubConsumerT.fromMap(e),
  //       )
  //       .toList();
  //   subconsumerT = temp;
  //   notifyListeners();
  //   log('subconsumerT length = ${subconsumerT?.length}');
  // }

  Future<List<String>?> getConsumersNames() async {
    List<Map<String, Object?>> re = await _dbModel.getConsumersNames();
    List<String>? temp = re
        .map(
          (e) => e['name'] as String,
        )
        .toList();
    consumersNames = temp;
    update();

    log('consumersNames length ${consumersNames?.length}');
    return consumersNames;
  }

  Future<int> addConsumer(String name) async {
    var x = await _dbModel.addConsumer(name);
    getConsumerForTable();
    log('{$x}');
    return x;
  }

  Future<int> addSubonsumer(SubConsumer subconsumer) async {
    var x = await _dbModel.addSubonsumer(subconsumer);

    log('{$x}');
    return x;
  }

  Future<int> updateConsumer(AppConsumers consumer) async {
    var x = await _dbModel.updateConsumer(consumer);
    getConsumerForTable();
    update();
    return x;
  }

  Future<int> deleteConsumer(int id) async {
    var x = await _dbModel.deleteConsumer(id);
    getConsumerForTable();
    log('delete {$x}');
    update();
    return x;
  }

  void onTopUpdate() async {
    if (formKey.currentState!.validate()) {
      var x = await updateConsumer(AppConsumers(
          name: consumerNameController.text,
          subConsumerCount: consumer?.subConsumerCount,
          operationsCount: consumer?.operationsCount,
          id: consumer?.id));
      log('update Consumer -> $x');
      consumerNameController.clear();
      if (x != 0) {
        Get.showSnackbar(mySnackBar.showSnackBar(
            title: 'تم', message: 'تم تعديل المستهلك بنجاح'));
      }
    }
  }

  void opTap() async {
    if (formKey.currentState!.validate()) {
      var x = await addConsumer(consumerNameController.text);
      consumerNameController.clear();
      if (x != 0) {
        Get.showSnackbar(
            mySnackBar.showSnackBar(title: 'تم', message: 'تم انشاء الملف'));
      }
    }
  }

  void deleteConsumerTap() async {
    var x = await deleteConsumer(consumer?.id ?? 0);
    if (x != 0) {
      Get.showSnackbar(mySnackBar.showSnackBar(
          title: 'تم', message: 'تم حذف المستهلك بنجاح'));
    }
  }

  void updateConsumerTap() async {
    if (formKey.currentState!.validate()) {
      var x = await updateConsumer(AppConsumers(
          name: consumerNameController.text,
          subConsumerCount: consumer?.subConsumerCount,
          operationsCount: consumer?.operationsCount,
          id: consumer?.id));
      if (x != 0) {
        Get.showSnackbar(mySnackBar.showSnackBar(
            title: 'تم', message: 'تم تعديل المستهلك بنجاح'));
      }
    }
  }
}
