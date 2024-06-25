import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_management_app/Model/operation.dart';
import 'package:intl/intl.dart';

import '../Model/DBModel.dart';
import '../Model/operationT.dart';

class OpProvider extends ChangeNotifier {
  final DBModel _dbModel = DBModel();
  OpProvider() {
    getLastTenOpT();
  }
  TextEditingController description = TextEditingController();
  TextEditingController amountCon = TextEditingController();
  TextEditingController subConsumerDetails = TextEditingController();
  TextEditingController fuelTypeCon = TextEditingController();
  TextEditingController consumerName = TextEditingController();
  TextEditingController receiverName = TextEditingController();
  TextEditingController dischangeNumber = TextEditingController();
  DateTime? _date;
  List<OperationT>? operations;
  List<OperationT>? lastTenOp;
  double? _amount;
  String _fuelType = 'سولار';
  bool? _checked;
  String get hintText {
    return (date) == null
        ? 'yyyy-MM-dd'
        : DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
  }

  DateTime? get date {
    return _date;
  }

  double? get amount {
    return _amount;
  }

  dropItem(String? value) {
    log('$value');
    if (value != null) {
      _fuelType = value;
    }
  }

  setDate(DateTime? date) {
    if (date != null) {
      _date = date;
      notifyListeners();
    }
  }

  setAmount(String? amount) {
    if (amount != null) {
      _amount = double.parse(amount);
      notifyListeners();
    }
  }

  setFuelType(String value) {
    _fuelType = value;
    notifyListeners();
  }

  changeCheck(bool? value) {
    _checked = value;
    notifyListeners();
  }

  bool? get checked {
    return _checked;
  }

  String? get fuelType {
    return _fuelType;
  }

  Future<List<OperationT>?> getLastTenOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getLastTenOp();
    List<OperationT>? temp = re
        .map(
          (e) => OperationT.fromMap(e),
        )
        .toList();
    lastTenOp = temp;
    notifyListeners();

    log('the length of Last = ${lastTenOp?.length}');
    return lastTenOp;
  }

  void getAllOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getAllOp();
    List<OperationT>? temp = re
        .map(
          (e) => OperationT.fromMap(e),
        )
        .toList();
    operations = temp;
    notifyListeners();

    log('the length of operation = ${operations?.length}');
  }

  Future<Operation> getOp(int opId) async {
    List<Map<String, Object?>> re = await _dbModel.getOp(opId);
    List<Operation>? temp = re
        .map(
          (e) => Operation.fromMap(e),
        )
        .toList();
    return temp.first;
  }

  addOperationWared(OperationT op) async {
    var x = await _dbModel.addOperationWard(op);
    log('{$x}');
    return x;
  }
}
