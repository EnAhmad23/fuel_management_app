import 'dart:developer';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

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
  TextEditingController dischangeNumberCon = TextEditingController();
  TextEditingController amountCon = TextEditingController();
  TextEditingController subConsumerDetails = TextEditingController();
  TextEditingController fuelTypeCon = TextEditingController();
  TextEditingController consumerName = TextEditingController();
  TextEditingController receiverName = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  DateTime? _date;
  List<OperationT>? operations;
  List<OperationT>? lastTenOp;
  List<String>? consumerNames;
  List<String>? subconsumerNames;

  double? _amount;
  String? _fuelType;
  String? _conName;
  String? _subconName;
  bool? _checked;
  String? get subconName {
    return _conName;
  }

  String? get conName {
    return _subconName;
  }

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

  setConName(String? name) {
    if (name != null) {
      _conName = name;
      notifyListeners();
    }
  }

  setSubConName(String? name) {
    if (name != null) {
      _subconName = name;
      notifyListeners();
    }
  }

  dropItem(String? value) {
    log('$value');
    if (value != null) {
      _fuelType = value;
      notifyListeners();
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

  void getConsumersNames() async {
    List<Map<String, Object?>> re = await _dbModel.getConsumersNames();
    consumerNames = re.map(
      (e) {
        return '${e['name']}';
      },
    ).toList();
    notifyListeners();
  }

  void getSubonsumersNames(String? conName) async {
    List<Map<String, Object?>> re =
        await _dbModel.getSubconsumersNames(conName);
    subconsumerNames = re.map(
      (e) {
        return '${e['details']}';
      },
    ).toList();
    notifyListeners();
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

  addOperationSarf(OperationT op) async {
    var x = await _dbModel.addOperation(op);
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

  void onTopSarf() async {
    if (formKey.currentState!.validate()) {
      setAmount(amountCon.text);
      var x = await addOperationSarf(
        OperationT(
            subConsumerDetails: subconName,
            consumerName: conName,
            receiverName: receiverName.text,
            type: 'صرف',
            checked: checked,
            dischangeNumber: dischangeNumberCon.text,
            foulType: fuelType,
            amount: amount,
            newDate: date,
            description: description.text),
      );
      amountCon.clear();
      description.clear();
      fuelTypeCon.clear();
      receiverName.clear();
      dischangeNumberCon.clear();
      subConsumerDetails.clear();
      consumerName.clear();
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
