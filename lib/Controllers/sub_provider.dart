import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/subconsumer.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';
import 'package:get/get.dart';

class SubProvider extends ChangeNotifier {
  SubProvider() {
    getSubConsumerT();
  }
  final DBModel _dbModel = DBModel();
  GlobalKey<FormState> formKey = GlobalKey();
  int? numOfOp;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController subName = TextEditingController();
  TextEditingController subDescription = TextEditingController();
  List<SubConsumer>? subconsumer;
  List<SubConsumerT>? subconsumerT;

  List<String>? consumersNames;
  String? dropdownValue;
  bool? _hasRecord;
  bool? get hasRcord {
    return _hasRecord;
  }

  void changRecord(bool hasRecord) {
    _hasRecord = hasRecord;
    notifyListeners();
  }

  changeDropdownValue(String? newValue) {
    dropdownValue = newValue;
    notifyListeners();
  }

  String? conNameValidtor(String? value) {
    if (value == null || value.isEmpty) {
      return 'أختار اسم المستهلك الرئيسي';
    }
    return null;
  }

  String? subNameValidtor(String? value) {
    if (value == null || value.isEmpty) {
      return 'أدخل اسم المستهلك';
    }
    return null;
  }

  String? descriptionValidtor(String? value) {
    if (value == null || value.isEmpty) {
      return 'أدخل تفاصيل المستهلك';
    }
    return null;
  }

  Future<List<SubConsumerT>?> getSubConsumerT() async {
    List<Map<String, Object?>> re = await _dbModel.getSubconsumerForTable();
    List<SubConsumerT>? temp = re.map(
      (e) {
        log('${e}');
        return SubConsumerT.fromMap(e);
      },
    ).toList();
    subconsumerT = temp;
    notifyListeners();
    log('subconsumerT length = ${subconsumerT?.length}');
    return subconsumerT;
  }

  getNumOfOp(int subconsumerId) async {
    int? temp = await _dbModel.getNumOfOp(subconsumerId);
    numOfOp = temp;
    notifyListeners();
    log('numOfOp = $numOfOp');
  }

  Future<List<String>?> getConsumersNames() async {
    List<Map<String, Object?>> re = await _dbModel.getConsumersNames();
    List<String>? temp = re
        .map(
          (e) => e['name'] as String,
        )
        .toList();
    consumersNames = temp;
    notifyListeners();

    log('consumersNames length ${consumersNames?.length}');
    return consumersNames;
  }

  Future<int> addSubonsumer(SubConsumer subconsumer) async {
    var x = await _dbModel.addSubonsumer(subconsumer);
    getSubConsumerT();
    log('{$x}');
    return x;
  }

  Future<int> deleteSubconsumer(int id) async {
    var x = await _dbModel.deleteSubconsumer(id);
    getSubConsumerT();
    log(' delete{$x}');
    return x;
  }

  void onTapButton() {
    if (formKey.currentState!.validate()) {
      var done = addSubonsumer(SubConsumer(
          details: subName.text,
          description: subDescription.text,
          consumerName: dropdownValue!,
          hasRcord: hasRcord));
      description.clear();
      subName.clear();
      name.clear();
      subDescription.clear();
      changRecord(false);
      changeDropdownValue(null);

      if (done != 0) {
        Get.snackbar(
          'تم',
          'تم إضافة المستهلك بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }
}
