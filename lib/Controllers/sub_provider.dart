import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/subconsumer.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../UI/Widgets/my_snackbar.dart';

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
  TextEditingController dateCon = TextEditingController();
  TextEditingController recordCon = TextEditingController();
  List<SubConsumer>? subconsumer;
  List<SubConsumerT>? subconsumerT;
  SubConsumerT? _updatedSub;
  DateTime? _date;
  List<String>? consumersNames;
  String? dropdownValue;
  bool _hasRecord = false;
  String? _hintText;
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
      notifyListeners();
    }
  }

  setHintText(String? text) {
    if (text != null) {
      _hintText = text;

      notifyListeners();
    }
  }

  void setUpdatedSub(SubConsumerT sub) {
    _updatedSub = sub;
    notifyListeners();
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

  Future<int> updateSubonsumer(SubConsumer subconsumer) async {
    var x = await _dbModel.updateSubonsumer(subconsumer);
    getSubConsumerT();
    log('{$x}');
    return x;
  }

  void onTapButton() {
    if (formKey.currentState!.validate()) {
      var done = addSubonsumer(SubConsumer(
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
        MySnackbar.doneSnack(massege: 'تم إضافة المستهلك بنجاح');
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
      description.clear();
      subName.clear();
      name.clear();
      subDescription.clear();
      changRecord(false);
      changeDropdownValue(null);

      if (done != 0) {
        MySnackbar.doneSnack(massege: 'تم تعديل المستهلك بنجاح');
      }
    }
  }
}
