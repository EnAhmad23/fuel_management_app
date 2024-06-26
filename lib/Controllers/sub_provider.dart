import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/subconsumer.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';

class SubProvider extends ChangeNotifier {
  final DBModel _dbModel = DBModel();
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
}
