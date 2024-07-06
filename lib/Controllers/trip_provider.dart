import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/trip.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum Status { created, finished, activated }

extension MyStatues on Status {
  String get stringValue {
    switch (this) {
      case Status.created:
        return 'منشأة';
      case Status.finished:
        return 'منتهية';
      case Status.activated:
        return 'قيد التنفيذ';
      default:
        return '';
    }
  }
}

Status fromString(String string) {
  switch (string) {
    case 'منشأة':
      return Status.created;
    case 'منتهية':
      return Status.finished;
    case 'قيد التنفيذ':
      return Status.activated;
    default:
      throw Exception('Invalid enum value');
  }
}

class TripProvider extends ChangeNotifier {
  final DBModel _dbModel = DBModel();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController subNameCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController reasonCon = TextEditingController();
  TextEditingController recordBeforCon = TextEditingController();
  TextEditingController roadCon = TextEditingController();
  Status status = Status.created;
  List<String>? consumerNames;
  List<String>? subNames;
  String? _subConName;
  String? _road;
  String? _cause;
  String? _conName;
  String? _hintText;
  DateTime? _date;

  DateTime? get date {
    return _date;
  }

  String? get subConName {
    return _subConName;
  }

  String? get road {
    return _road;
  }

  String? get cause {
    return _cause;
  }

  String? get conName {
    return _conName;
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

  setSubConName(String? name) {
    if (name != null) {
      _subConName = name;
    }
  }

  setRoad(String? name) {
    if (name != null) {
      _road = name;
    }
  }

  setCause(String? name) {
    if (name != null) {
      _cause = name;
    }
  }

  setConName(String? name) {
    if (name != null) {
      _conName = name;
    }
  }

  setHintText(String? name) {
    if (name != null) {
      _hintText = name;
    }
  }

  Future<int?> addTrip(Trip trip) {
    return _dbModel.addTrip(trip);
  }

  void onTapButton() async {
    var x = await addTrip(Trip(
        subconName: subConName,
        status: status.stringValue,
        date: date,
        road: roadCon.text,
        cause: reasonCon.text));
    roadCon.clear();
    reasonCon.clear();
    setSubConName(null);
    setConName(null);
    if (x != 0) {
      Get.snackbar(
        'تم',
        'تم إضافة الرحلة بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
    }
  }

  getConusmersNames() async {
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
    log('-------------------------------------$re');
    subNames = re.map(
      (e) {
        return '${e['details']}';
      },
    ).toList();
    notifyListeners();
  }
}
