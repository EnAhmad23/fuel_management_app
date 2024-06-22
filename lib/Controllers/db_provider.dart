import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/consumer.dart';
import 'package:fuel_management_app/Model/operation.dart';
import 'package:fuel_management_app/Model/subconsumer.dart';

import '../Model/operationT.dart';
import '../Model/subconsumerT.dart';

class DbProvider extends ChangeNotifier {
  // Database? database;
  final DBModel _dbModel = DBModel();
  int? numOfOp;
  // Operation? operation;
  List<AppConsumers>? consumers;
  List<SubConsumer>? subconsumer;
  List<SubConsumerT>? subconsumerT;
  List<OperationT>? operations;
  List<String>? consumersNames;
  bool? _hasRecord;
  TextEditingController consumerNameController = TextEditingController();
  TextEditingController subName = TextEditingController();
  TextEditingController subDescription = TextEditingController();
  // DbProvider() {
  //   initDB();
  // }
  // initDB() async {
  //   database = await _dbModel.db;
  // }
  bool? get hasRcord {
    return _hasRecord;
  }

  void changRecord(bool hasRecord) {
    _hasRecord = hasRecord;
    notifyListeners();
  }

  Future<List<AppConsumers>?> getConsumerForTable() async {
    try {
      List<Map<String, Object?>> re = await _dbModel.getConsumerForTable();
      List<AppConsumers>? temp = re.map(
        (e) {
          return AppConsumers(
            name: e['consumer_name']?.toString() ?? '',
            subConsumerCount:
                int.tryParse(e['number_of_subconsumers']?.toString() ?? '0') ??
                    0,
            operationsCount:
                int.tryParse(e['number_of_operations']?.toString() ?? '0') ?? 0,
            id: int.tryParse(e['consumer_id']?.toString() ?? '0') ?? 0,
          );
        },
      ).toList();
      log('The length ${temp.length}');
      consumers = temp;
      notifyListeners();
      return consumers;
    } catch (e) {
      log('Error fetching data: $e');
      return null;
    }
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

  getNumOfOp(int subconsumerId) async {
    int? temp = await _dbModel.getNumOfOp(subconsumerId);
    numOfOp = temp;
    notifyListeners();
    log('numOfOp = $numOfOp');
  }

  Future<List<SubConsumerT>?> getSubConsumerT() async {
    List<Map<String, Object?>> re = await _dbModel.getSubconsumerForTable();
    List<SubConsumerT>? temp = re
        .map(
          (e) => SubConsumerT.fromMap(e),
        )
        .toList();
    subconsumerT = temp;
    notifyListeners();
    log('subconsumerT length = ${subconsumerT?.length}');
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

  Future<int> addConsumer(String name) async {
    var x = await _dbModel.addConsumer(name);
    log('{$x}');
    return x;
  }

  Future<int> addSubonsumer(SubConsumer subconsumer) async {
    var x = await _dbModel.addSubonsumer(subconsumer);
    log('{$x}');
    return x;
  }
}
