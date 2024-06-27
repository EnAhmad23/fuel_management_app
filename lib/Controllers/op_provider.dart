import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_management_app/Model/operation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Model/DBModel.dart';
import '../Model/operationT.dart';

class OpProvider extends ChangeNotifier {
  final DBModel _dbModel = DBModel();
  static final OpProvider _opProvider = OpProvider._();
  OpProvider._() {
    getLastTenOpT();
  }
  factory OpProvider() {
    return _opProvider;
  }
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController description = TextEditingController();
  TextEditingController amountCon = TextEditingController();
  TextEditingController subConsumerDetails = TextEditingController();
  TextEditingController fuelTypeCon = TextEditingController();
  TextEditingController consumerName = TextEditingController();
  TextEditingController receiverName = TextEditingController();
  TextEditingController dischangeNumber = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  DateTime? _date;
  List<OperationT>? operations;
  List<OperationT>? lastTenOp;
  double? _amount;
  String? _fuelType;
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

  String? fuelTypeValidator(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'الرجاء اخيار نوع الوقود ';
    }
    return null;
  }

  String? amontValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال كمية الوقود ';
    } else if (!value.isNumericOnly) {
      return 'الرجاء ادخال قيمة صحيحة';
    }
    return null;
  }

  String? dateValidet(String? value) {
    //-------------------------------------------------checked
    log('$value');
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال التاريح ';
    }
    return null;
  }

  void getLastTenOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getLastTenOp();
    lastTenOp = re.map(
      (e) {
        print('$e');
        OperationT operationT = OperationT.fromMap(e);
        print(operationT.newDate);
        return operationT;
      },
    ).toList();

    notifyListeners();

    log('the length of Last = ${lastTenOp?.length}');
  }

  void getAllOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getAllOp();
    operations = re
        .map(
          (e) => OperationT.fromMap(e),
        )
        .toList();
    log('$operations');
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
    getAllOpT();
    getLastTenOpT();
    return x;
  }

  deleteOperation(int id) async {
    var x = await _dbModel.deleteOperation(id);
    getAllOpT();
    getLastTenOpT();
    return x;
  }

  void onTopWared() async {
    if (formKey.currentState!.validate()) {
      setAmount(amountCon.text);
      var x = await addOperationWared(
        OperationT(
            subConsumerDetails: null,
            consumerName: null,
            receiverName: null,
            type: 'وارد',
            checked: checked,
            dischangeNumber: null,
            foulType: fuelType,
            amount: amount,
            newDate: date,
            description: description.text),
      );
      amountCon.clear();
      description.clear();
      fuelTypeCon.clear();
      changeCheck(false);
      setDate(null);
      if (x != 0) {
        Get.snackbar(
          'تم',
          'تم إضافة العملة بنجاح',
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
