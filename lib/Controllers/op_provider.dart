import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_management_app/Model/operation.dart';

import '../Model/DBModel.dart';
import '../Model/operationT.dart';

class OpProvider extends ChangeNotifier {
  final DBModel _dbModel = DBModel();
  TextEditingController wasfCon = TextEditingController();
  TextEditingController amountCon = TextEditingController();
  List<OperationT>? operations;
  String? _fuelType;
  bool? _checked;
  setFuelType(String? value) {
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

  void getLastTenOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getLastTenOp();
    List<OperationT>? temp = re
        .map(
          (e) => OperationT.fromMap(e),
        )
        .toList();
    operations = temp;
    notifyListeners();
    log('the length of operation = ${operations?.length}');
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
    var x = await _dbModel.addOperation(op);
    log('{$x}');
    return x;
  }
}
