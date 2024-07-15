import 'dart:developer';
import 'dart:io';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_management_app/Model/fuel_available_amount.dart';
import 'package:fuel_management_app/Model/operation.dart';
import 'package:fuel_management_app/UI/Widgets/my_snackbar.dart';
import 'package:fuel_management_app/UI/search_result.dart';
import 'package:fuel_management_app/UI/show_operation.dart';
import 'package:fuel_management_app/UI/update_operation_estrad.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Model/DBModel.dart';
import '../Model/operationT.dart';
import '../UI/update_operation_sarf.dart';
import 'package:pdf/widgets.dart' as pw;

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
    getNumOfAllOp();
    // getTotalSolarSarf();
    // getTotalBazenSarf();
    // getTotalSolarWard();
    // getTotalBazenWard();
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
  TextEditingController recordCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController fromDateCon = TextEditingController();

  DateTime? _date;
  DateTime? _fromdate;
  DateTime? _todate;
  OperationT? _operationT;
  List<FuelAvailableAmount>? fuelavailable;
  List<OperationT>? operations;
  List<OperationT>? subOperations;
  List<OperationT>? lastTenOp;
  List<String>? consumerNames;
  List<String>? subconsumerNames;
  String? doneMassege;
  String? _hintText;
  String? _formHintText;
  String? _toHintText;
  String? _subTitle;
  int? _amount;
  int? _subRecord;
  int? _numOfOp;
  String? _reportType;
  String? _operationType;
  String? _dailySarf;
  String? _totalAvailable;
  String? _monthlySarf;
  String? _monthlyWard;
  String? _totalSarf;
  String? _totalBazenSarf;
  String? _totalSolarSarf;
  String? _totalBazenWard;
  String? _totalSolarWard;
  String? _totalWard;
  String? _weeklySarf;
  String? _fuelType;
  String? _conName;
  String? _subconName;
  bool? _checked;
  bool? hasRecord;

  OperationT? get operationT {
    return _operationT;
  }

  String? get subTitle {
    return _subTitle;
  }

  String? get totalBazenSarf {
    return _totalBazenSarf;
  }

  String? get totalSolarSarf {
    return _totalSolarSarf;
  }

  String? get totalBazenWard {
    return _totalBazenWard;
  }

  String? get totalSolarWard {
    return _totalSolarWard;
  }

  String? get reportType {
    return _reportType;
  }

  String? get operationType {
    return _operationType;
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

  String get fromHintText {
    return (fromdate) == null
        ? 'yyyy-MM-dd'
        : DateFormat('yyyy-MM-dd').format(fromdate ?? DateTime.now());
  }

  String get toHintText {
    return (todate) == null
        ? 'yyyy-MM-dd'
        : DateFormat('yyyy-MM-dd').format(todate ?? DateTime.now());
  }

  DateTime? get date {
    return _date;
  }

  DateTime? get fromdate {
    return _fromdate;
  }

  DateTime? get todate {
    return _todate;
  }

  int? get amount {
    return _amount;
  }

  int? get subRecord {
    return _subRecord;
  }

  int? get numOfOp {
    return _numOfOp;
  }

  setUpdatedOperation(OperationT op) {
    _operationT = op;
    notifyListeners();
  }

  setHintText(String? text) {
    if (text != null) {
      _hintText = text;

      notifyListeners();
    }
  }

  setReportType(String? text) {
    if (text != null) {
      _reportType = text;

      notifyListeners();
    }
  }

  setOperationType(String? text) {
    _operationType = text;
    notifyListeners();
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

  setTotalSolarSarf(String? value) {
    if (value != null) {
      _totalSolarSarf = value;

      notifyListeners();
    }
  }

  setTotalBazenSarf(String? value) {
    if (value != null) {
      _totalBazenSarf = value;

      notifyListeners();
    }
  }

  setTotalSolarWard(String? value) {
    if (value != null) {
      _totalSolarWard = value;

      notifyListeners();
    }
  }

  setTotalBazenWard(String? value) {
    if (value != null) {
      _totalBazenWard = value;

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
    _subconName = name;
    notifyListeners();
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

  setFromDate(DateTime? date) {
    if (date != null) {
      _fromdate = date;
      notifyListeners();
    }
  }

  setToDate(DateTime? date) {
    if (date != null) {
      _todate = date;
      notifyListeners();
    }
  }

  setAmount(String? amount) {
    if (amount != null) {
      _amount = int.parse(amount);
      notifyListeners();
    }
  }

  setSubRecord(String? amount) {
    if (amount != null) {
      _subRecord = int.parse(amount);
      notifyListeners();
    }
  }

  setNumOfOp(int? num) {
    if (num != null) {
      _numOfOp = num;
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
    if (value == null || value.isEmpty || value == 'اختر نوع الوقود') {
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

  String? receiverValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال أسم المستلم ';
    }
    return null;
  }

  String? dischangeNumberValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال سند الصرف ';
    }
    return null;
  }

  String? subNameValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'الرجاء اختيار المستهلك الفرعي ';
    }
    return null;
  }

  String? conNameValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'الرجاء اختيار المستهلك الرئيسي ';
    }
    return null;
  }

  String? reportValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty || value == 'اختر نوع التقرير') {
      return ' الرجاء اختيار نوع التقرير ';
    }
    return null;
  }

  String? operationTypeValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return ' الرجاء اختيار نوع العملية ';
    }
    return null;
  }

  String? dateValidet(String? value) {
    //-------------------------------------------------check the history for see if it was wark well
    log('$value');
    if (hintText == 'yyyy-MM-dd' || hintText.isEmpty) {
      return 'الرجاء ادخال التاريخ ';
    }
    return null;
  }

  String? toDateValidet(String? value) {
    //-------------------------------------------------check the history for see if it was wark well
    log('$value');
    if (fromHintText == 'yyyy-MM-dd' && toHintText == 'yyyy-MM-dd') {
      return null;
    } else if (toHintText == 'yyyy-MM-dd' || toHintText.isEmpty) {
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

  getNumOfAllOp() async {
    int? temp = await _dbModel.getNumOfAllOp();
    setNumOfOp(temp);
    notifyListeners();
    log('numOfOp = $numOfOp');
  }

  void getDailySarf() async {
    int re = await _dbModel.getDailySarf();
    log('Daily Sarf -> $re');

    setDailySarf('$re');
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

  // void getTotalSolarSarf() async {
  //   Map<String, dynamic> re = await _dbModel.getTotalSolarSarf();
  //   log('Total Sarf -> ${re['total_exchange_amount']}');
  //   if (re.isNotEmpty && re['total_exchange_amount'] != null) {
  //     setTotalSolarSarf('${re['total_exchange_amount']}');
  //   } else {
  //     setTotalSolarSarf('0.0');
  //   }
  // }

  // void getTotalBazenSarf() async {
  //   Map<String, dynamic> re = await _dbModel.getTotaBansenSarf();
  //   log('Total Sarf -> ${re['total_exchange_amount']}');
  //   if (re.isNotEmpty && re['total_exchange_amount'] != null) {
  //     setTotalBazenSarf('${re['total_exchange_amount']}');
  //   } else {
  //     setTotalBazenSarf('0.0');
  //   }
  // }

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

  // void getTotalSolarWard() async {
  //   Map<String, dynamic> re = await _dbModel.getTotalSolarWard();
  //   log('Total Ward -> ${re['total_exchange_amount']}');
  //   if (re.isNotEmpty && re['total_exchange_amount'] != null) {
  //     setTotalSolarWard('${re['total_exchange_amount']}');
  //   } else {
  //     setTotalSolarWard('0.0');
  //   }
  // }

  // void getTotalBazenWard() async {
  //   Map<String, dynamic> re = await _dbModel.getTotalBanzenWard();
  //   log('Total Ward -> ${re['total_exchange_amount']}');
  //   if (re.isNotEmpty && re['total_exchange_amount'] != null) {
  //     setTotalBazenWard('${re['total_exchange_amount']}');
  //   } else {
  //     setTotalBazenWard('0.0');
  //   }
  // }

  void getMonthlyWard() async {
    Map<String, dynamic> re = await _dbModel.getMonthlyWard();
    log('Monthly Ward -> ${re['total_amount']}');
    if (re.isNotEmpty && re['total_amount'] != null) {
      setMonthlyWard('${re['total_amount']}');
    } else {
      setMonthlyWard('0.0');
    }
  }

  void getLastTenOpT() async {
    List<Map<String, Object?>> re = await _dbModel.getLastTenOp();
    lastTenOp = re.map(
      (e) {
        OperationT operationT = OperationT.fromMap(e);
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
        OperationT operationT = OperationT.fromMap(e);
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
        OperationT operationT = OperationT.fromMap(e);
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
        OperationT operationT = OperationT.fromMap(e);
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

  void searchOperation(OperationT operation) async {
    List<Map<String, Object?>> re = await _dbModel.getAllOp();
    operations = re.map(
      (e) {
        log('operations $e');
        return OperationT.fromMap(e);
      },
    ).toList();
    log('$operations');
    if (operation.subConsumerDetails != null) {
      operations = operations
          ?.where(
            (element) =>
                element.subConsumerDetails == operation.subConsumerDetails,
          )
          .toList();
    }
    if (operation.consumerName != null) {
      operations = operations
          ?.where(
            (element) => element.consumerName == operation.consumerName,
          )
          .toList();
    }

    if (operation.foulType != null) {
      operations = operations
          ?.where(
            (element) => element.foulType == operation.foulType,
          )
          .toList();
    }

    log('-*-*-*-*-*-*-*-**-*${operations}');
    if (operation.type != null) {
      operations = operations?.where(
        (element) {
          log('-*-*-*-*-*-*-*-**-*${element.type}');
          log('-*-*-*-*-*-*-*-**-*${operation.type}');
          return element.type == operation.type;
        },
      ).toList();
    }
    log('-*-*-*-*-*-*-*-**-*${operations?.length}');
    if (operation.amount != null) {
      operations = operations
          ?.where(
            (element) => element.amount == operation.amount,
          )
          .toList();
    }
    log('-*-*-*-*-*-*-*-**-*${operations?.length}');
    if (operation.dischangeNumber != null) {
      operations = operations?.where(
        (element) {
          log('8888888888 ${operation.dischangeNumber}//');
          log('8888888888${element.dischangeNumber}');
          return element.dischangeNumber == operation.dischangeNumber;
        },
      ).toList();
    }
    log('-*-*-*-*-*-*-*-**-*${operations?.length}');
    if (operation.newDate != null && fromdate != null && todate != null) {
      operations = operations?.where(
        (element) {
          log('111111111111${operation.newDate}');
          log('111111111111${element.newDate}');
          return element.newDate!.isAfter(fromdate!) &&
              element.newDate!.isBefore(todate!);
        },
      ).toList();
    }
    notifyListeners();

    log('the length of operation = ${operations?.length}');
  }

  void getFuelAvailable() async {
    List<Map<String, Object?>> re = await _dbModel.getFuelAvailabel();
    fuelavailable = re.map(
      (e) {
        log('operations $e');
        return FuelAvailableAmount.fromMap(e);
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
    getNumOfAllOp();
    // getTotalSolarWard();
    // getTotalBazenWard();
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
    getNumOfAllOp();
    // getTotalSolarSarf();
    // getTotalBazenSarf();
    return x;
  }

  Future<int?>? updateOperationSarf(OperationT? op) async {
    var x = await _dbModel.updateOperation(op);
    log('{$x}');
    getTotalAvailable();
    getTotalSarf();
    getMonthlySarf();
    getWeeklySarf();
    getDailySarf();
    getAllOpT();
    getLastTenOpT();
    getTotalAvailable();
    getNumOfAllOp();
    // getTotalSolarSarf();
    // getTotalBazenSarf();
    return x;
  }

  Future<int?>? updateOperationWard(OperationT op) async {
    var x = await _dbModel.updateOperation(op);
    log('{$x}');
    getTotalAvailable();
    getTotalWard();
    getMonthlyWard();
    getAllOpT();
    getLastTenOpT();
    getNumOfAllOp();
    // getTotalSolarWard();
    // getTotalBazenWard();
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
    getNumOfAllOp();
    // getTotalSolarSarf();
    // getTotalBazenSarf();
    // getTotalSolarWard();
    // getTotalBazenWard();
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

      if (x != 0) {
        MySnackbar.doneSnack(massege: 'تم إضافة العملية بنجاح');
        clearWardFeild();
      }
    }
  }

  void onTopSarf() async {
    if (formKey.currentState!.validate()) {
      setAmount(amountCon.text);
      // setDate(fromdate!.difference(todate!).inDays as DateTime?);
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
      log('////////////////////////// -> ${recordCon.text}');

      if (x != 0) {
        MySnackbar.doneSnack(massege: 'تم إضافة العملية بنجاح');
        clearSarfFeild();
      }
    }
  }

  Future<int> addMovementRecord(String subName, int record) async {
    var x = await _dbModel.addMovementRecord(subName, record);
    log('///{$x}');
    return x;
  }

  void onTopSearch() async {
    if (formKey.currentState!.validate()) {
      var x = todate?.difference(fromdate!);
      log('$todate');
      log('$fromdate');
      log('$x');

      setDate(fromdate?.add(x!));
      searchOperation(
        OperationT(
            subConsumerDetails: subconName,
            consumerName: conName,
            receiverName: receiverName.text,
            type: operationType,
            checked: checked,
            dischangeNumber:
                dischangeNumberCon.text == '' ? null : dischangeNumberCon.text,
            foulType: fuelType,
            amount: amount,
            newDate: date,
            description: description.text),
      );
      Get.to(const SearchResult());
    }
  }

  void onTopUpdateSarf() async {
    if (formKey.currentState!.validate()) {
      log('$subconName-----------$conName');
      setAmount(amountCon.text);
      var x = await updateOperationSarf(OperationT(
          id: operationT?.id,
          subConsumerDetails: subconName,
          consumerName: conName,
          receiverName: receiverName.text,
          type: 'صرف',
          checked: checked,
          dischangeNumber: dischangeNumberCon.text,
          foulType: fuelType,
          amount: amount,
          newDate: date,
          description: description.text));

      if (x != 0) {
        MySnackbar.doneSnack(massege: 'تم تعديل العملية بنجاح');
        clearSarfFeild();
      }
    }
  }

  void onTopUpdateWared() async {
    if (formKey.currentState!.validate()) {
      setAmount((amountCon.text));
      var x = await updateOperationWard(OperationT(
        id: operationT?.id,
        subConsumerDetails: null,
        consumerName: null,
        receiverName: null,
        type: 'وارد',
        checked: checked,
        dischangeNumber: null,
        foulType: fuelType,
        amount: amount,
        newDate: date,
        description: description.text,
      ));
      clearWardFeild();
      if (x != 0) {
        MySnackbar.doneSnack(massege: 'تم تعديل العملية بنجاح');
      }
    }
  }

  checkOperationType(OperationT operation) {
    if (operation.type == 'صرف') {
      setFuelType('${operation.foulType}');
      dischangeNumberCon.text = '${operation.dischangeNumber}';
      description.text = '${operation.description}';
      getConsumersNames();
      setConName('${operation.consumerName}');
      setDate(operation.newDate!);
      log('operation.subConsumerDeails - >${operation.subConsumerDetails}');
      getSubonsumersNames(operation.consumerName);
      // setSubConName(null);
      log('subconame - >$subconName');
      setAmount('${int.parse('${operation.amount}')}');
      amountCon.text = '${operation.amount}';
      changeCheck(operation.checked);
      receiverName.text = '${operation.receiverName}';
      setUpdatedOperation(operation);
      Get.to(const UpdateOperationSarf());
    } else {
      amountCon.text = '${int.parse('${operation.amount}')}';
      description.text = '${operation.description}';
      setHintText('yyyy-MM-dd');
      changeCheck(operation.checked);
      setDate(operation.newDate!);
      setFuelType('${operation.foulType}');
      setUpdatedOperation(operation);
      Get.to(const UpdateOperationEstrad());
    }
  }

  clearSarfFeild() {
    amountCon.clear();
    description.clear();
    setFuelType(null);
    receiverName.clear();
    dischangeNumberCon.clear();
    subConsumerDetails.clear();
    consumerName.clear();
    changeCheck(false);
    setDate(null);
    setHintText('yyyy-MM-dd');
    recordCon.clear();
  }

  clearWardFeild() {
    amountCon.clear();
    description.clear();
    setFuelType(null);
    changeCheck(false);
    setDate(null);
    setHintText('yyyy-MM-dd');
  }

  Future<void> generatePdf(
      BuildContext context, List<OperationT> operations) async {
    double sarfBanzen = 0.0;
    double sarfSoler = 0.0;
    double waredBanzen = 0.0;
    double waredSoler = 0.0;

    for (var e in operations) {
      if (e.type == 'صرف' && e.foulType == 'بنزين') {
        sarfBanzen += double.parse('${e.amount}');
      } else if (e.type == 'صرف' && e.foulType == 'سولار') {
        sarfSoler += double.parse('${e.amount}');
      } else if (e.type == 'وارد' && e.foulType == 'بنزين') {
        waredBanzen += double.parse('${e.amount}');
      } else if (e.type == 'وارد' && e.foulType == 'سولار') {
        waredSoler += double.parse('${e.amount}');
      }
    }
    setNumOfOp(operations?.length);
    setTotalBazenSarf('$sarfBanzen');
    setTotalSolarSarf('$sarfSoler');
    setTotalBazenWard('$waredBanzen');
    setTotalSolarWard('$waredSoler');
    final pdf = pw.Document();
    final beirutiFont = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Beiruti-VariableFont_wght.ttf'));
    final arialFont = pw.Font.ttf(
        await rootBundle.load('assets/fonts/arfonts-arial-bold.ttf'));
    final segoeFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/segoe.UI.ttf'));

    // Load the images
    final right = pw.MemoryImage(
      (await rootBundle.load('assets/images/right.jpeg')).buffer.asUint8List(),
    );
    final body = pw.MemoryImage(
      (await rootBundle.load('assets/images/bady.png')).buffer.asUint8List(),
    );
    final left = pw.MemoryImage(
      (await rootBundle.load('assets/images/left.jpeg')).buffer.asUint8List(),
    );
    final mid = pw.MemoryImage(
      (await rootBundle.load('assets/images/mid.jpeg')).buffer.asUint8List(),
    );

    // Add a multi-page with the images and table
    pdf.addPage(
      pw.MultiPage(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: beirutiFont,
          bold: arialFont,
        ),
        header: (pw.Context context) {
          // Custom header for the table on each page
          return (context.pageNumber == 1)
              ? pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        width: 170,
                        height: 150,
                        child: pw.Image(right),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Container(
                        width: 120,
                        height: 150,
                        child: pw.Image(mid),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Container(
                        width: 170,
                        height: 150,
                        child: pw.Image(left),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                  // pw.SizedBox(height: 10),
                  pw.Align(
                    alignment: pw.Alignment.topRight,
                    child: pw.Container(
                      width: 300,
                      height: 150,
                      child: pw.Image(body),
                    ),
                  ),
                  pw.SizedBox(height: 50),
                ])
              : pw.SizedBox();
        },
        footer: (pw.Context context) {
          // Only show the footer on the last page
          if (context.pageNumber == context.pagesCount) {
            return pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'التوقيع',
                    style: pw.TextStyle(font: beirutiFont, fontSize: 18),
                  ),
                  pw.Text(
                    'رئيس قسم المحروقات',
                    style: pw.TextStyle(font: beirutiFont, fontSize: 18),
                  ),
                ],
              ),
            );
          }
          return pw.Container(); // Return an empty container for non-last pages
        },
        build: (pw.Context context) {
          // Custom table build function
          return [
            pw.TableHelper.fromTextArray(
              headers: [
                'التاريخ',
                'الكمية',
                'نوع الوقود',
                'سند الصرف',
                'النوع',
                'اسم المستلم',
                'المستهلك الأساسي',
                'المستهلك',
                '#'
              ],
              headerStyle: pw.TextStyle(font: beirutiFont, fontSize: 12),
              cellStyle: pw.TextStyle(font: beirutiFont, fontSize: 10),
              cellAlignment: pw.Alignment.center,
              data: operations.map((operation) {
                return [
                  operation.formattedDate ?? '',
                  operation.amount ?? '',
                  operation.foulType ?? '',
                  operation.dischangeNumber ?? '',
                  operation.type ?? '',
                  operation.receiverName ?? '',
                  operation.consumerName ?? '',
                  operation.subConsumerDetails ?? '',
                  operations.indexOf(operation) + 1
                ];
              }).toList(),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.TableHelper.fromTextArray(
                  headers: ['القيمة', 'التفاصيل'],
                  headerStyle: pw.TextStyle(font: beirutiFont, fontSize: 12),
                  cellStyle: pw.TextStyle(font: beirutiFont, fontSize: 10),
                  cellAlignment: pw.Alignment.center,
                  data: [
                    (numOfOp != null && numOfOp != 0)
                        ? ['$numOfOp', 'عدد العمليات']
                        : [],
                    (totalSolarSarf != null && totalSolarSarf != '0.0')
                        ? [totalSolarSarf, 'كمبة السولار المصروفة']
                        : [],
                    (totalBazenSarf != null && totalBazenSarf != '0.0')
                        ? [totalBazenSarf, 'كمبة البنزين المصروفة']
                        : [],
                    (totalSolarWard != null && totalSolarWard != '0.0')
                        ? [totalSolarWard, 'كمبة السولار الواردة']
                        : [],
                    (totalBazenWard != null && totalBazenWard != '0.0')
                        ? [totalBazenWard, 'كمبة البنزين الواردة']
                        : [],
                  ],
                ),
              ],
            ),
          ];
        },
      ),
    );

    // Let the user pick a directory and save the PDF file
    String? outputFilePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF',
      fileName: 'operations.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (outputFilePath == null) {
      // User canceled the file picker
      return;
    }

    final file = File(outputFilePath);

    await file.writeAsBytes(await pdf.save());
  }
}
