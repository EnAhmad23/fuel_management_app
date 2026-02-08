import 'dart:developer';
import 'dart:io';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/models/fuel_available_amount.dart';
import 'package:fuel_management_app/models/operation.dart';
import 'package:fuel_management_app/views/Widgets/custom_snackbar.dart';
import 'package:fuel_management_app/views/screens/operation/search_result.dart';
import 'package:fuel_management_app/views/screens/operation/update_operation_estrad.dart';
import '../views/screens/operation/update_operation_sarf.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../models/DBModel.dart';
import '../models/operationT.dart';
import 'package:pdf/widgets.dart' as pw;

class OpController extends GetxController {
  final DBModel _dbModel = DBModel();
  static final OpController _opController = OpController._();
  OpController._() {
    getLastTenOpT();
    getDailySarf();
    getWeeklySarf();
    getMonthlySarf();
    getTotalSarf();
    getTotalWard();
    getMonthlyWard();
    getMonthlyAllOperations();
    getTotalAvailable();
    getNumOfAllOp();
    // getTotalSolarSarf();
    // getTotalBazenSarf();
    // getTotalSolarWard();
    // getTotalBazenWard();
  }
  factory OpController() {
    return _opController;
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
  List<String>? months;
  Set<String>? years;
  List<Map<String, Object?>>? _monthYearOptions;
  String? doneMassege;
  String? _hintText;
  String? _formHintText;
  String? _toHintText;
  String? _subTitle;
  String? _month;
  String? _year;
  int? _amount;
  int? _subRecord;
  int? _numOfOp;
  String? _reportType;
  String? _operationType;
  String? _dailySarf;
  String? _totalAvailable;
  String? _monthlySarf;
  String? _monthlyWard;
  String? _monthlyAllOperations;
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
  bool _disable = false;
  double? _excessSolar;
  double? _excessGasoline;
  CustomSnackBar mySnackBar = const CustomSnackBar();
  double? get excessSolar {
    return _excessSolar;
  }

  double? get excessGasoline {
    return _excessGasoline;
  }

  String? get month {
    return _month;
  }

  String? get year {
    return _year;
  }

  bool get disable {
    return _disable;
  }

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

  String? get monthlyAllOperations {
    return _monthlyAllOperations;
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

  set month(String? value) {
    _month = value;
    update();
  }

  set year(String? value) {
    _year = value;
    _refreshAvailableMonths();
    update();
  }

  void _refreshAvailableMonths() {
    final options = _monthYearOptions;
    if (options == null) {
      return;
    }

    final filtered = (_year == null)
        ? options
        : options.where((e) => '${e['year']}' == _year).toList();

    final m = filtered.map((e) => '${e['month']}').toSet().toList();
    m.sort();
    months = m;

    if (_month != null && !(months?.contains(_month) ?? false)) {
      _month = null;
    }
  }

  setUpdatedOperation(OperationT op) {
    _operationT = op;
    update();
  }

  setHintText(String? text) {
    if (text != null) {
      _hintText = text;

      update();
    }
  }

  setReportType(String? text) {
    if (text != null) {
      _reportType = text;

      update();
    }
  }

  setOperationType(String? text) {
    _operationType = text;
    update();
  }

  setSubTitle(String? name) {
    if (name != null) {
      _subTitle = name;

      update();
    }
  }

  setConName(String? name) {
    if (name != null) {
      _conName = name;

      update();
    }
  }

  setDailySarf(String? value) {
    if (value != null) {
      _dailySarf = value;

      update();
    }
  }

  set disable(bool? value) {
    if (value != null) {
      _disable = value;
    }
    update();
  }

  setTotalSarf(String? value) {
    if (value != null) {
      _totalSarf = value;

      update();
    }
  }

  setTotalSolarSarf(String? value) {
    if (value != null) {
      _totalSolarSarf = value;

      update();
    }
  }

  setTotalBazenSarf(String? value) {
    if (value != null) {
      _totalBazenSarf = value;

      update();
    }
  }

  setTotalSolarWard(String? value) {
    if (value != null) {
      _totalSolarWard = value;

      update();
    }
  }

  setTotalBazenWard(String? value) {
    if (value != null) {
      _totalBazenWard = value;

      update();
    }
  }

  setTotalAvailable(String? value) {
    if (value != null) {
      _totalAvailable = value;

      update();
    }
  }

  setTotalWard(String? value) {
    if (value != null) {
      _totalWard = value;

      update();
    }
  }

  setMonthlySarf(String? value) {
    if (value != null) {
      _monthlySarf = value;

      update();
    }
  }

  setMonthlyWard(String? value) {
    if (value != null) {
      _monthlyWard = value;

      update();
    }
  }

  setMonthlyAllOperations(String? value) {
    if (value != null) {
      _monthlyAllOperations = value;
      update();
    }
  }

  setWeeklySarf(String? value) {
    if (value != null) {
      _weeklySarf = value;

      update();
    }
  }

  setSubConName(String? name) {
    _subconName = name;
    update();
  }

  dropItem(String? value) {
    log('$value');
    if (value != null) {
      _fuelType = value;
      update();
    }
  }

  setDate(DateTime? date) {
    if (date != null) {
      _date = date;
      update();
    }
  }

  setFromDate(DateTime? date) {
    if (date != null) {
      _fromdate = date;
      update();
    }
  }

  setToDate(DateTime? date) {
    if (date != null) {
      _todate = date;
      update();
    }
  }

  setAmount(String? amount) {
    if (amount != null) {
      _amount = int.parse(amount);
      update();
    }
  }

  setSubRecord(String? amount) {
    if (amount != null) {
      _subRecord = int.parse(amount);
      update();
    }
  }

  setNumOfOp(int? num) {
    if (num != null) {
      _numOfOp = num;
      update();
    }
  }

  set excessGasoline(double? value) {
    _excessGasoline = value;
  }

  set excessSolar(double? value) {
    _excessSolar = value;
  }

  setFuelType(String? value) {
    _fuelType = value;
    update();
  }

  changeCheck(bool? value) {
    _checked = value;
    update();
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

  String? monthValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'يجب إختيار الشهر';
    }
    return null;
  }

  String? yearValidet(String? value) {
    //-----------------------------------------------checked
    if (value == null || value.isEmpty) {
      return 'يجب إختيار السنة';
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
    update();
  }

  void getSubonsumersNames(String? conName) async {
    List<Map<String, Object?>> re =
        await _dbModel.getSubconsumersNames(conName);

    subconsumerNames = re.map(
      (e) {
        return '${e['details']}';
      },
    ).toList();
    update();
  }

  getNumOfAllOp() async {
    int? temp = await _dbModel.getNumOfAllOp();
    setNumOfOp(temp);
    update();
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
      double total = double.parse('${re['net_amount']}') +
          (excessGasoline ?? 0.0) +
          (excessSolar ?? 0.0);
      setTotalAvailable('$total');
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

  void getMonthlyAllOperations() async {
    Map<String, dynamic> re = await _dbModel.getMonthlyAllOperationsSum();
    log('Monthly All Operations -> ${re['total_amount']}');
    if (re.isNotEmpty && re['total_amount'] != null) {
      setMonthlyAllOperations('${re['total_amount']}');
    } else {
      setMonthlyAllOperations('0.0');
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

    update();

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

    update();

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

    update();

    log('the length of DailySubOP = ${lastTenOp?.length}');
  }

  Future<void> getMonthlySubOP() async {
    List<Map<String, Object?>> re = await _dbModel.getMontlySubOp();
    subOperations = re.map(
      (e) {
        OperationT operationT = OperationT.fromMap(e);
        return operationT;
      },
    ).toList();

    update();

    log('the length of Monthly SubOP = ${subOperations?.length}');
  }

  Future<void> getMonthlySarfSubOP() async {
    List<Map<String, Object?>> re = await _dbModel.getMonthlySarfSubOp();
    subOperations = re.map(
      (e) {
        OperationT operationT = OperationT.fromMap(e);
        return operationT;
      },
    ).toList();

    update();

    log('the length of Monthly Sarf SubOP = ${subOperations?.length}');
  }

  void getTotalSubOP(String? type) async {
    List<Map<String, Object?>> re = await _dbModel.getTotalSubOp(type);
    subOperations = re.map(
      (e) {
        OperationT operationT = OperationT.fromMap(e);
        return operationT;
      },
    ).toList();

    update();

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
    update();

    log('the length of operation = ${operations?.length}');
  }

  void searchOperation(OperationT operation) async {
    List<Map<String, Object?>> re = await _dbModel.getAllOpSearch();
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

    log('-*-*-*-*-*-*-*-**-*$operations');
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
    if (operation.checked != null) {
      operations = operations?.where(
        (element) {
          log('8888888888 ${operation.dischangeNumber}//');
          log('8888888888${element.dischangeNumber}');
          return element.checked == operation.checked;
        },
      ).toList();
    }
    log('-*-*-*-*-*-*-*-**-*${operations?.length}');

    if (operation.newDate != null) {
      final target = operation.newDate!;
      operations = operations?.where(
        (element) {
          final d = element.newDate;
          if (d == null) return false;
          return d.year == target.year &&
              d.month == target.month &&
              d.day == target.day;
        },
      ).toList();
    } else if (fromdate != null && todate != null) {
      final from = DateTime(fromdate!.year, fromdate!.month, fromdate!.day);
      final to = DateTime(todate!.year, todate!.month, todate!.day, 23, 59, 59);
      operations = operations?.where(
        (element) {
          final d = element.newDate;
          if (d == null) return false;
          return !d.isBefore(from) && !d.isAfter(to);
        },
      ).toList();
    }
    update();

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

    // Adding excess fuel to the available fuel
    if (fuelavailable != null) {
      // Process excess solar fuel
      if (excessSolar != null && excessSolar! > 0) {
        bool solarFound = false;
        for (var e in fuelavailable!) {
          if (e.fuelType == 'سولار') {
            e.amount = ((e.amount ?? 0) + excessSolar!);
            solarFound = true;
            break;
          }
        }
        if (!solarFound) {
          fuelavailable!
              .add(FuelAvailableAmount(fuelType: 'سولار', amount: excessSolar));
        }
      }
      if (excessGasoline != null && excessGasoline! > 0) {
        bool gasolineFound = false;
        for (var e in fuelavailable!) {
          if (e.fuelType == 'بنرين') {
            e.amount = ((e.amount ?? 0) + excessGasoline!);
            gasolineFound = true;
            break;
          }
        }
        if (!gasolineFound) {
          fuelavailable!.add(
              FuelAvailableAmount(fuelType: 'بنرين', amount: excessGasoline));
        }
      }
    }
    update();
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
    update();

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
    getMonthlyAllOperations();
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
    getMonthlyAllOperations();
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
    getMonthlyAllOperations();
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
    getMonthlyAllOperations();
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
    getMonthlyAllOperations();
    getWeeklySarf();
    getDailySarf();
    getAllOpT();
    getLastTenOpT();
    getNumOfAllOp();
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
        Get.showSnackbar(mySnackBar.showSnackBar(
            title: 'تم', message: 'تم إضافة العملية بنجاح'));
        clearWardFeild();
      }
    }
  }

  void onTopSarf() async {
    // Check if there is any available fuel before proceeding
    final availableFuel = double.tryParse(totalAvailable ?? '0') ?? 0;
    if (availableFuel <= 0) {
      Get.showSnackbar(mySnackBar.showSnackBar(
          backgroundColor: Colors.red,
          title: 'خطأ',
          lottieAssetPath: 'assets/json/warning.json',
          titleColor: Colors.white,
          messageColor: Colors.white,
          message: 'لا توجد كمية وقود متاحة لإتمام هذه العملية'));
      return;
    }

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
          description: description.text,
        ),
      );

      log('////////////////////////// -> ${recordCon.text}');

      if (x != 0) {
        Get.showSnackbar(mySnackBar.showSnackBar(
            title: 'تم', message: 'تم إضافة العملية بنجاح'));
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
    final formState = formKey.currentState;
    if (formState == null) {
      return;
    }
    if (formState.validate()) {
      if (reportType == 'تقرير يومي' && date == null) {
        Get.showSnackbar(
          mySnackBar.showSnackBar(
            backgroundColor: Colors.red,
            title: 'خطأ',
            lottieAssetPath: 'assets/json/warning.json',
            titleColor: Colors.white,
            messageColor: Colors.white,
            message: 'الرجاء تحديد التاريخ',
          ),
        );
        return;
      }

      final hasFrom = fromdate != null;
      final hasTo = todate != null;
      if (hasFrom != hasTo) {
        Get.showSnackbar(
          mySnackBar.showSnackBar(
            backgroundColor: Colors.red,
            title: 'خطأ',
            lottieAssetPath: 'assets/json/warning.json',
            titleColor: Colors.white,
            messageColor: Colors.white,
            message: 'الرجاء تحديد تاريخ البداية وتاريخ النهاية معاً',
          ),
        );
        return;
      }

      if (hasFrom && hasTo && todate!.isBefore(fromdate!)) {
        Get.showSnackbar(
          mySnackBar.showSnackBar(
            backgroundColor: Colors.red,
            title: 'خطأ',
            lottieAssetPath: 'assets/json/warning.json',
            titleColor: Colors.white,
            messageColor: Colors.white,
            message: 'تاريخ النهاية يجب أن يكون بعد تاريخ البداية',
          ),
        );
        return;
      }

      log('$todate');
      log('$fromdate');

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
            newDate: reportType == 'تقرير يومي' ? date : null,
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
        Get.showSnackbar(mySnackBar.showSnackBar(
            title: 'تم', message: 'تم تعديل العملية بنجاح'));
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
        Get.showSnackbar(mySnackBar.showSnackBar(
            title: 'تم', message: 'تم تعديل العملية بنجاح'));
      }
    }
  }

  Future<int> trheilOperation(int month, int year) async {
    int re = await _dbModel.trheilLOperation(month, year);
    log('ttttttttttttttttttttttttttttttt $re');
    log('ttttttttttttttttttttttttttttttt $month');
    log('ttttttttttttttttttttttttttttttt $year');
    return re;
  }

  ({int month, int year}) _getPreviousMonthYear(int month, int year) {
    if (month <= 1) {
      return (month: 12, year: year - 1);
    }
    return (month: month - 1, year: year);
  }

  Future<bool> _canCloseMonthSequentially(int month, int year) async {
    final prev = _getPreviousMonthYear(month, year);
    if (prev.year <= 0) {
      return true;
    }
    final prevOpenCount =
        await _dbModel.getOpenOperationsCountForMonth(prev.month, prev.year);
    return prevOpenCount == 0;
  }

  getExcessFuel() async {
    // Ensure month and year are parsed correctly
    int parsedMonth = int.parse(month ?? '0');
    int parsedYear = int.parse(year ?? '0');
    List<Map<String, Object?>> re =
        await _dbModel.getExcessFuel(parsedMonth, parsedYear);
    excessGasoline = 0.0;
    excessSolar = 0.0;

    if (re.isNotEmpty) {
      for (var e in re) {
        var foulType = e['foulType'] as String?;
        var excessAmount = e['excess_amount'] as num?;

        if (foulType != null && excessAmount != null) {
          if (foulType == 'بنزين') {
            excessGasoline = excessAmount.toDouble();
          } else if (foulType == 'سولار') {
            excessSolar = excessAmount.toDouble();
          }
        }
      }
    }
  }

  void onTapClose() async {
    if (formKey.currentState!.validate()) {
      if (month != null && year != null) {
        final selectedMonth = int.parse(month!);
        final selectedYear = int.parse(year!);
        final canClose =
            await _canCloseMonthSequentially(selectedMonth, selectedYear);
        if (!canClose) {
          final prev = _getPreviousMonthYear(selectedMonth, selectedYear);
          Get.showSnackbar(
            mySnackBar.showSnackBar(
              backgroundColor: Colors.red,
              title: 'خطأ',
              lottieAssetPath: 'assets/json/warning.json',
              titleColor: Colors.white,
              messageColor: Colors.white,
              message:
                  'لا يمكن إغلاق الشهر الحالي قبل إغلاق الشهر السابق (${prev.month}/${prev.year})',
            ),
          );
          return;
        }

        Get.defaultDialog(
            title: 'حذف',
            backgroundColor: Colors.white,
            content: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  SizedBox(
                      height: 100.h,
                      width: 200.h,
                      child: Lottie.asset('assets/json/warning.json')),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Text('هل متاكد من إغلاق الملف ؟'),
                ],
              ),
            ),
            confirm: InkWell(
              onTap: () async {
                var x = await trheilOperation(selectedMonth, selectedYear);
                Get.back();
                refreshCloseOperation();
                if (x != 0) {
                  Get.showSnackbar(mySnackBar.showSnackBar(
                      title: 'تم', message: ' تم إغلاق ملف شهر $month'));
                  month = null;
                  year = null;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5.r)),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: EdgeInsets.all(10.w),
                child: const Text(
                  'نعم',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            cancel: InkWell(
              onTap: () => Get.back(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: const Text(
                  'لا',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ));
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

      disable = subconsumerNames != null &&
          !(subconsumerNames!.contains(operation.subConsumerDetails));

      // setSubConName(null);
      log('subconame - >$subconName');
      setSubConName(operation.subConsumerDetails);
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
    setSubConName(null);
    setConName(null);
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

  getMonthsAndYears() async {
    List<Map<String, Object?>> re = await _dbModel.getMonthes();
    _monthYearOptions = re;
    years = (re.map(
      (element) {
        return '${element['year']}';
      },
    ).toSet());
    _refreshAvailableMonths();
    update();
  }

  getOperationOfDate() async {
    List<Map<String, Object?>> re = await _dbModel.getAllOp();
    operations = re.map(
      (e) {
        return OperationT.fromMap(e);
      },
    ).toList();

    if (operations != null) {
      if (month != null) {
        operations = operations
            ?.where((element) => element.newDate?.month == int.parse('$month'))
            .toList();
      }
      if (year != null) {
        operations = operations
            ?.where((element) => element.newDate?.year == int.parse('$year'))
            .toList();
      }
    }

    update();
  }

  void showDeleteSuccessSnackbar() {
    Get.snackbar(
      'تم',
      'تم حذف العنصر بنجاح',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  refreshCloseOperation() {
    getAllOpT();
    getLastTenOpT();
    getOperationOfDate();
    getExcessFuel();
    getMonthlySarf();
    getDailySarf();
    getWeeklySarf();
    getMonthlyWard();
    getMonthlyAllOperations();
    getTotalAvailable();
    getTotalSarf();
    getTotalWard();
    getMonthsAndYears();
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
    setNumOfOp(operations.length);
    setTotalBazenSarf('$sarfBanzen');
    setTotalSolarSarf('$sarfSoler');
    setTotalBazenWard('$waredBanzen');
    setTotalSolarWard('$waredSoler');
    final pdf = pw.Document();
    final beirutiFont = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Beiruti-VariableFont_wght.ttf'));
    final arialFont = pw.Font.ttf(
        await rootBundle.load('assets/fonts/arfonts-arial-bold.ttf'));

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
          base: arialFont,
          bold: beirutiFont,
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
          return pw.Container();
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
              headerStyle: pw.TextStyle(font: arialFont, fontSize: 12),
              cellStyle: pw.TextStyle(
                  font: arialFont,
                  fontSize: 10,
                  fontWeight: pw.FontWeight.normal),
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
                  headerStyle: pw.TextStyle(font: arialFont, fontSize: 12),
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
    if (Platform.isWindows) {
      Process.run('cmd', ['/c', 'start', '', file.path]);
    } else {
      throw UnsupportedError('Opening files is not supported on this platform');
    }
  }
}
