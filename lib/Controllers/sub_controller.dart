import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_management_app/models/DBModel.dart';
import 'package:fuel_management_app/models/movement.dart';
import 'package:fuel_management_app/models/operationT.dart';
import 'package:fuel_management_app/models/subconsumer.dart';
import 'package:fuel_management_app/models/subconsumerT.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/Widgets/custom_snackbar.dart';

class SubController extends GetxController {
  SubController() {
    getSubConsumerT();
  }
  final DBModel _dbModel = DBModel();
  GlobalKey<FormState> formKey = GlobalKey();
  int? numOfOp;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController subName = TextEditingController();
  TextEditingController subDescription = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController recordCon = TextEditingController();
  List<SubConsumerT>? subconsumerOfCon;
  List<SubConsumerT>? subconsumerT;
  List<Movement>? movementRecords;
  List<OperationT>? subOperations;
  double? distance;
  SubConsumerT? _updatedSub;
  int? id;
  int lastRecord = 0;
  DateTime? _date;
  List<String>? consumersNames;
  String? dropdownValue;
  bool _hasRecord = false;
  String? _hintText;
  CustomSnackBar mySnackBar = const CustomSnackBar();
  bool get hasRcord {
    return _hasRecord;
  }

  DateTime? get date {
    return _date;
  }

  SubConsumerT? get updatedSub {
    return _updatedSub;
  }

  String? get hintText {
    return (date) == null
        ? 'yyyy-MM-dd'
        : DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
  }

  setDate(DateTime? date) {
    if (date != null) {
      _date = date;
      update();
    }
  }

  setHintText(String? text) {
    if (text != null) {
      _hintText = text;

      update();
    }
  }

  void setUpdatedSub(SubConsumerT sub) {
    _updatedSub = sub;
    update();
  }

  void changRecord(bool hasRecord) {
    _hasRecord = hasRecord;
    update();
  }

  changeDropdownValue(String? newValue) {
    dropdownValue = newValue;
    update();
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

  String? recordValidtor(String? value) {
    if (value == null || value.isEmpty) {
      return 'أدخل قراءة العداد';
    } else if (!value.isNumericOnly) {
      return 'أدخل قيمة صحيحة';
    }
    return null;
  }

  Future<List<SubConsumerT>?> getSubConsumerT() async {
    List<Map<String, Object?>> re = await _dbModel.getSubconsumerForTable();
    List<SubConsumerT>? temp = re.map(
      (e) {
        log('$e');
        return SubConsumerT.fromMap(e);
      },
    ).toList();
    subconsumerT = temp;
    update();
    log('subconsumerT length = ${subconsumerT?.length}');
    return subconsumerT;
  }

  Future<List<OperationT>?> getAllSubOp(int? id) async {
    List<Map<String, Object?>> re = await _dbModel.getAllSubOp(id);
    List<OperationT>? temp = re.map(
      (e) {
        log('$e');
        return OperationT.fromMap(e);
      },
    ).toList();
    subOperations = temp;
    update();
    log('subOperations length = ${subOperations?.length}');
    return subOperations;
  }

  Future<List<SubConsumerT>?> getSubConsumerOfCon(String? conName) async {
    List<Map<String, Object?>> re =
        await _dbModel.getSubconsumersOfCon(conName);
    List<SubConsumerT>? temp = re.map(
      (e) {
        log('$e');
        return SubConsumerT.fromMap(e);
      },
    ).toList();
    subconsumerOfCon = temp;
    update();
    log('subconsumerT length = ${subconsumerT?.length}');
    return subconsumerT;
  }

  getHasRecord(String? subName) async {
    int? temp = await _dbModel.getSubonsumerHasRecord(subName);
    changRecord(temp == 1);
  }

  getSubRecordName(String? subName) async {
    lastRecord = await _dbModel.getSubRecordName(subName);
    update();
  }

  getNumOfOp(int subconsumerId) async {
    int? temp = await _dbModel.getNumOfOp(subconsumerId);
    numOfOp = temp;
    update();
    log('numOfOp = $numOfOp');
  }

  getDistanceBetweenLastTwoRecords(int subconsumerId) async {
    distance = await _dbModel.getDistanceBetweenLastTwoRecords(subconsumerId);
    log('getDistanceBetweenLastTwoRecords -> $distance');
  }

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

  getMovementRecord(int subID) async {
    List<Map<String, Object?>> re = await _dbModel.getMovmentRcords(subID);
    movementRecords = re.map(
      (e) {
        log('movemnet - > $e');
        return Movement.fromMap(e);
      },
    ).toList();
    update();
  }

  Future<int> addSubonsumer(SubConsumer subconsumer) async {
    var x = await _dbModel.addSubonsumer(subconsumer);
    getSubConsumerT();
    log('{$x}');
    return x;
  }

  Future<int> addMovementRecord(String subName, int record) async {
    var x = await _dbModel.addMovementRecord(subName, record);
    log('{$x}');
    return x;
  }

  Future<int> deleteSubconsumer(int id) async {
    var x = await _dbModel.deleteSubconsumer(id);
    getSubConsumerT();
    log(' delete{$x}');
    return x;
  }

  Future<int> deleteMovement(int id, int subID) async {
    var x = await _dbModel.deleteMovementRecord(id);
    getMovementRecord(subID);
    log(' delete{$x}');
    return x;
  }

  Future<int> updateSubonsumer(SubConsumer subconsumer) async {
    var x = await _dbModel.updateSubonsumer(subconsumer);
    getSubConsumerT();
    log('{$x}');
    return x;
  }

  void onTapButton() async {
    if (formKey.currentState!.validate()) {
      var done = await addSubonsumer(SubConsumer(
        details: subName.text,
        description: subDescription.text,
        consumerName: dropdownValue!,
        hasRcord: hasRcord,
        record: hasRcord ? int.parse(recordCon.text) : null,
        date: date,
      ));
      description.clear();
      subName.clear();
      name.clear();
      subDescription.clear();
      changRecord(false);
      changeDropdownValue(null);

      if (done != 0) {
        Get.showSnackbar(
            mySnackBar.showSnackBar(message: 'تم إضافة المستهلك بنجاح'));
      }
    }
  }

  void onTapUpdateSub() async {
    if (formKey.currentState!.validate()) {
      var done = await updateSubonsumer(SubConsumer(
        id: updatedSub?.id,
        details: subName.text,
        description: subDescription.text,
        consumerName: dropdownValue!,
        hasRcord: hasRcord,
      ));
      clearFields();

      if (done != 0) {
        Get.showSnackbar(
            mySnackBar.showSnackBar(message: 'تم تعديل المستهلك بنجاح'));
      }
    }
  }

  void clearFields() {
    description.clear();
    subName.clear();
    name.clear();
    subDescription.clear();
    changRecord(false);
    changeDropdownValue(null);
  }
}
