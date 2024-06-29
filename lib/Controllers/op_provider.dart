import 'dart:developer';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
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
    getDailySarf();
    getWeeklySarf();
    getMonthlySarf();
    getTotalSarf();
    getTotalWard();
    getMonthlyWard();
    getTotalAvailable();
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
  List<OperationT>? subOperations;
  List<OperationT>? lastTenOp;
  List<String>? consumerNames;
  List<String>? subconsumerNames;

  String? _subTitle;
  double? _amount;
  String? _dailySarf;
  String? _totalAvailable;
  String? _monthlySarf;
  String? _monthlyWard;
  String? _totalSarf;
  String? _totalWard;
  String? _weeklySarf;
  String? _fuelType;
  String? _conName;
  String? _subconName;
  bool? _checked;

  String? get subTitle {
    return _subTitle;
  }

  String? get subconName {
    return _subconName;
  }

  String? get dailySarf {
    return _dailySarf;
  }

  String? get totalSarf {
    return _totalSarf;
  }

  String? get totalAvailable {
    return _totalAvailable;
  }

  String? get totalWard {
    return _totalWard;
  }

  String? get weeklySarf {
    return _weeklySarf;
  }

  String? get monthlySarf {
    return _monthlySarf;
  }

  String? get monthlyWard {
    return _monthlyWard;
  }

  String? get conName {
    return _conName;
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

  setSubTitle(String? name) {
    if (name != null) {
      _subTitle = name;

      notifyListeners();
    }
  }

  setConName(String? name) {
    if (name != null) {
      _conName = name;

      notifyListeners();
    }
  }

  setDailySarf(String? value) {
    if (value != null) {
      _dailySarf = value;

      notifyListeners();
    }
  }

  setTotalSarf(String? value) {
    if (value != null) {
      _totalSarf = value;

      notifyListeners();
    }
  }

  setTotalAvailable(String? value) {
    if (value != null) {
      _totalAvailable = value;

      notifyListeners();
    }
  }

  setTotalWard(String? value) {
    if (value != null) {
      _totalWard = value;

      notifyListeners();
    }
  }

  setMonthlySarf(String? value) {
    if (value != null) {
      _monthlySarf = value;

      notifyListeners();
    }
  }

  setMonthlyWard(String? value) {
    if (value != null) {
      _monthlyWard = value;

      notifyListeners();
    }
  }

  setWeeklySarf(String? value) {
    if (value != null) {
      _weeklySarf = value;

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
    //-------------------------------------------------check the history for see if it was wark well
    log('$value');
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال التاريخ ';
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

  void getDailySarf() async {
    Map<String, dynamic> re = await _dbModel.getDailySarf();
    log('Daily Sarf -> $re');
    if (re.isNotEmpty && re['total_exchange_amount'] != null) {
      setDailySarf('${re['total_exchange_amount']}');
    } else {
      setDailySarf('0.0');
    }
  }

  void getMonthlySarf() async {
    Map<String, dynamic> re = await _dbModel.getMonthlySarf();
    log('Monthly Sarf -> ${re['total_exchange_amount']}');
    if (re.isNotEmpty && re['total_exchange_amount'] != null) {
      setMonthlySarf('${re['total_exchange_amount']}');
    } else {
      setMonthlySarf('0.0');
    }
  }

  void getWeeklySarf() async {
    Map<String, dynamic> re = await _dbModel.getWeeklySarf();
    log('Weekly Sarf -> ${re['total_exchange_amount']}');
    if (re.isNotEmpty && re['total_exchange_amount'] != null) {
      setWeeklySarf('${re['total_exchange_amount']}');
    } else {
      setWeeklySarf('0.0');
    }
  }

  void getTotalSarf() async {
    Map<String, dynamic> re = await _dbModel.getTotalSarf();
    log('Total Sarf -> ${re['total_exchange_amount']}');
    if (re.isNotEmpty && re['total_exchange_amount'] != null) {
      setTotalSarf('${re['total_exchange_amount']}');
    } else {
      setTotalSarf('0.0');
    }
  }

  void getTotalAvailable() async {
    Map<String, dynamic> re = await _dbModel.getTotalAvailable();
    log('Total Available -> ${re['net_amount']}');
    if (re.isNotEmpty && re['net_amount'] != null) {
      setTotalAvailable('${re['net_amount']}');
    } else {
      setTotalAvailable('0.0');
    }
  }

  void getTotalWard() async {
    Map<String, dynamic> re = await _dbModel.getTotalWard();
    log('Total Ward -> ${re['total_exchange_amount']}');
    if (re.isNotEmpty && re['total_exchange_amount'] != null) {
      setTotalWard('${re['total_exchange_amount']}');
    } else {
      setTotalWard('0.0');
    }
  }

  void getMonthlyWard() async {
    Map<String, dynamic> re = await _dbModel.getMonthlyWard();
    log('Monthly Ward -> ${re['total_exchange_amount']}');
    if (re.isNotEmpty && re['total_exchange_amount'] != null) {
      setMonthlyWard('${re['total_exchange_amount']}');
    } else {
      setMonthlyWard('0.0');
    }
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

  void getDailySubOP() async {
    List<Map<String, Object?>> re = await _dbModel.getDailyOp();
    subOperations = re.map(
      (e) {
        log('$e');
        OperationT operationT = OperationT.fromMap(e);
        print(operationT.newDate);
        return operationT;
      },
    ).toList();

    notifyListeners();

    log('the length of DailySubOP = ${lastTenOp?.length}');
  }

  void getWeeklySubOP() async {
    List<Map<String, Object?>> re = await _dbModel.getWeeklySubOp();
    subOperations = re.map(
      (e) {
        print('$e');
        OperationT operationT = OperationT.fromMap(e);
        print(operationT.newDate);
        return operationT;
      },
    ).toList();

    notifyListeners();

    log('the length of DailySubOP = ${lastTenOp?.length}');
  }

  void getMonthlySubOP(String? type) async {
    List<Map<String, Object?>> re = await _dbModel.getMontlySubOp(type);
    subOperations = re.map(
      (e) {
        print('$e');
        OperationT operationT = OperationT.fromMap(e);
        print(operationT.newDate);
        return operationT;
      },
    ).toList();

    notifyListeners();

    log('the length of DailySubOP = ${lastTenOp?.length}');
  }

  void getTotalSubOP(String? type) async {
    List<Map<String, Object?>> re = await _dbModel.getTotalSubOp(type);
    subOperations = re.map(
      (e) {
        print('$e');
        OperationT operationT = OperationT.fromMap(e);
        print(operationT.newDate);
        return operationT;
      },
    ).toList();

    notifyListeners();

    log('the length of DailySubOP = ${lastTenOp?.length}');
  }

  void getAllOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getAllOp();
    operations = re.map(
      (e) {
        log('operations $e');
        return OperationT.fromMap(e);
      },
    ).toList();
    log('$operations');
    notifyListeners();

    log('the length of operation = ${operations?.length}');
  }

  void getDailyOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getDailyOp();
    operations = re.map(
      (e) {
        log('operations $e');
        return OperationT.fromMap(e);
      },
    ).toList();
    log('$operations');
    notifyListeners();

    log('the length of daily operation = ${operations?.length}');
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
    getTotalWard();
    getMonthlyWard();
    getAllOpT();
    getLastTenOpT();
    getTotalAvailable();
    return x;
  }

  addOperationSarf(OperationT op) async {
    var x = await _dbModel.addOperation(op);
    log('{$x}');
    getTotalSarf();
    getMonthlySarf();
    getWeeklySarf();
    getDailySarf();
    getAllOpT();
    getLastTenOpT();
    getTotalAvailable();
    return x;
  }

  deleteOperation(int id) async {
    var x = await _dbModel.deleteOperation(id);
    getTotalAvailable();
    getTotalWard();
    getTotalSarf();
    getMonthlyWard();
    getMonthlySarf();
    getWeeklySarf();
    getDailySarf();
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
