import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/trip.dart';
import 'package:fuel_management_app/UI/update_trip.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../UI/Widgets/my_snackbar.dart';

enum Status { created, finished, activated, canceled }

extension MyStatues on Status {
  String get stringValue {
    switch (this) {
      case Status.created:
        return 'منشأة';
      case Status.finished:
        return 'منتهية';
      case Status.activated:
        return 'قيد التنفيذ';
      case Status.canceled:
        return 'ملغية';
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
    case 'ملغية':
      return Status.canceled;
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
  TextEditingController recordCon = TextEditingController();
  TextEditingController roadCon = TextEditingController();
  Trip? _updatedTrip;

  Trip? get updatedTrip => _updatedTrip;

  set updatedTrip(Trip? value) {
    _updatedTrip = value;
  }

  Status _status = Status.created;
  int? _recordBefor;
  int? _distation;
  int? _recordAfter;
  List<String>? consumerNames;
  List<String>? subNames;
  List<Trip>? trips;
  String? _subConName;
  String? _road;
  String? _cause;
  String? _conName;
  String? _hintText;
  DateTime? _date;

  int? get recordBefor {
    return _recordBefor;
  }

  int? get distation {
    return _distation;
  }

  int? get recordAfter {
    return _recordAfter;
  }

  DateTime? get date {
    return _date;
  }

  String? get subConName {
    return _subConName;
  }

  String? get status {
    return _status.stringValue;
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
    _subConName = name;
    notifyListeners();
  }

  setRecordBefor(int? num) {
    if (num != null) {
      _recordBefor = num;
      notifyListeners();
    }
  }

  setRecordAfter(int? num) {
    if (num != null) {
      _recordAfter = num;
      notifyListeners();
    }
  }

  setDistation(int? num) {
    if (num != null) {
      _distation = num;
      notifyListeners();
    }
  }

  setRoad(String? name) {
    if (name != null) {
      _road = name;
      notifyListeners();
    }
  }

  setStatus(String? name) {
    if (name != null) {
      _status = fromString(name);
      notifyListeners();
    }
  }

  setCause(String? name) {
    if (name != null) {
      _cause = name;
      notifyListeners();
    }
  }

  setConName(String? name) {
    _conName = name;
    notifyListeners();
  }

  setHintText(String? name) {
    if (name != null) {
      _hintText = name;
      notifyListeners();
    }
  }

  String? consumerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إختيار المستهلك ';
    }
    return null;
  }

  String? roadValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال وجهة الرحلة';
    }
    return null;
  }

  String? recordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'أدخل قيمة العداد';
    } else if (int.parse(value) < (recordAfter ?? 0)) {
      return 'يجب انو تكون القراءة أكبر من القراءة السابقة';
    }
    return null;
  }

  Future<int?> addTrip(Trip trip) {
    return _dbModel.addTrip(trip);
  }

  void onTapButton() async {
    var x = await addTrip(Trip(
        subconName: subConName,
        status: status,
        date: date,
        road: roadCon.text,
        cause: reasonCon.text));
    roadCon.clear();
    reasonCon.clear();
    setSubConName(null);
    setConName(null);
    if (x != 0) {
      MySnackbar.doneSnack(massege: 'تم إضافة الرحلة بنجاح');
    }
  }

  void goToUpdate(Trip trip) async {
    getConusmersNames();
    roadCon.text = '${trip.road}';
    subNameCon.text = '${trip.subconName}';
    reasonCon.text = '${trip.cause}';
    setSubConName(trip.subconName);
    String? conname = await getConusmersName(trip.subconName);
    setConName(conname);
    updatedTrip = trip;
    Get.to(const UpdateTrip());
  }

  void onTapUpdate() async {
    if (formKey.currentState!.validate()) {
      var x = await updateTrip(Trip(
          id: updatedTrip?.id,
          subconName: subConName,
          status: status,
          date: date,
          road: roadCon.text,
          cause: reasonCon.text));

      if (x != 0) {
        MySnackbar.doneSnack(massege: 'تم تعديل الرحلة بنجاح');
        roadCon.clear();
        reasonCon.clear();
        setSubConName(null);
        setConName(null);
        getTrips();
      }
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

  Future<String?> getConusmersName(String? subName) async {
    String? name = await _dbModel.getConsumerName(subName);
    return name;
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

  void getTrips() async {
    List<Map<String, Object?>> re = await _dbModel.getTrips();
    log('$re');
    trips = re.map(
      (e) {
        log('$e');
        return Trip.fromMap(e);
      },
    ).toList();
    notifyListeners();
  }

  Future<int> updateStartTrip(String? status, int? id) async {
    var x = await _dbModel.updateStartTrip(status, id);
    return x;
  }

  Future<int> updateTrip(Trip trip) async {
    var x = await _dbModel.updateTrip(trip);
    return x;
  }

  Future<int> deleteTrip(int id) async {
    var x = await _dbModel.deleteTrip(id);
    getTrips();
    return x;
  }

  Future<int> updateTripRecord(int? recordBefor, int? id) async {
    log('65564564645$id');
    var x = await _dbModel.updateTripRecord(recordBefor, id);
    log('$x');
    return x;
  }

  Future<int> updateRecordAfter(int? recordAfter, int? id) async {
    log('65564564645$id');
    var x = await _dbModel.updateRecordAfter(recordAfter, id);
    log('$x');
    return x;
  }

  void startTrip(Trip trip) {
    Get.defaultDialog(
        title: '',
        backgroundColor: Colors.white,
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Consumer<TripProvider>(builder: (context, pro, x) {
            return Column(
              children: [
                Text(
                  '    أدخل قراءة العداد    ',
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'أدخل قيمة العداد';
                      }
                    },
                    controller: pro.recordBeforCon,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            );
          }),
        ),
        confirm: Consumer<TripProvider>(builder: (context, pro, x) {
          return InkWell(
            onTap: () {
              if (formKey.currentState!.validate()) {
                setStatus(Status.activated.stringValue);
                setRecordBefor(int.parse(recordBeforCon.text));
                pro.updateStartTrip(status, trip.id);
                pro.updateTripRecord(recordBefor, trip.id);
                pro.getTrips();
                setStatus(Status.created.stringValue);
                Get.back();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5.r)),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              padding: EdgeInsets.all(10.w),
              child: const Text(
                ' بدء ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }),
        cancel: InkWell(
          onTap: () => Get.back(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(5.r)),
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: const Text(
              'الغاء',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }

  void endTrip(Trip trip) {
    Get.defaultDialog(
        title: '',
        backgroundColor: Colors.white,
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Consumer<TripProvider>(builder: (context, pro, x) {
            return Column(
              children: [
                Text(
                  '        أدخل قراءة العداد        ',
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    validator: pro.recordValidator,
                    controller: pro.recordCon,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            );
          }),
        ),
        confirm: Consumer<TripProvider>(builder: (context, pro, x) {
          return InkWell(
            onTap: () {
              if (formKey.currentState!.validate()) {
                setStatus(Status.finished.stringValue);
                if (int.parse(recordCon.text) > (recordAfter ?? 0)) {
                  setRecordAfter(int.parse(recordCon.text));
                }
                pro.updateStartTrip(status, trip.id);
                pro.updateRecordAfter(recordAfter, trip.id);
                setDistation((recordAfter ?? 0) - (recordBefor ?? 0));
                setStatus(Status.created.stringValue);
                pro.getTrips();
                recordCon.clear();
                Get.back();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(5.r)),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              padding: EdgeInsets.all(10.w),
              child: const Text(
                ' إنهاء ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }),
        cancel: InkWell(
          onTap: () => Get.back(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(5.r)),
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: const Text(
              'الغاء',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }

  void clearFields() {
    roadCon.clear();
    reasonCon.clear();
    setSubConName(null);
    setConName(null);
  }
}
