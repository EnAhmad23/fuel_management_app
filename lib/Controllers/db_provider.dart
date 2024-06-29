import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/consumer.dart';
import 'package:fuel_management_app/Model/subconsumer.dart';

import '../Model/operationT.dart';
// ignore: unused_import
import '../Model/subconsumerT.dart';

class DbProvider extends ChangeNotifier {
  // Database? database;
  final DBModel _dbModel = DBModel();
  int? numOfOp;
  int? numOfSub;
  DbProvider() {
    getNumOfSubconsumers();
  }
  // Operation? operation;
  GlobalKey<FormState> formKey = GlobalKey();
  List<AppConsumers>? consumers;
  List<OperationT>? operations;
  List<String>? consumersNames;

  TextEditingController consumerNameController = TextEditingController();
  // DbProvider() {
  //   initDB();
  // }
  // initDB() async {
  //   database = await _dbModel.db;
  // }
  String? nameValidtor(String? value) {
    if (value == null || value.isEmpty) {
      return 'أدخل اسم المستهلك';
    }
    return null;
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
                int.tryParse(e['number_of_operations']?.toString() ?? '0'),
            id: int.tryParse(e['consumer_id']?.toString() ?? '0'),
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

  getNumOfOp(int subconsumerId) async {
    int? temp = await _dbModel.getNumOfOp(subconsumerId);
    numOfOp = temp;
    notifyListeners();
    log('numOfOp = $numOfOp');
  }

  void getNumOfSubconsumers() async {
    numOfSub = await _dbModel.getNumOfSubconsumers() ?? 0;
    log('Number of consumers -> $numOfSub');
    notifyListeners();
  }

  // Future<List<SubConsumerT>?> getSubConsumerT() async {
  //   List<Map<String, Object?>> re = await _dbModel.getSubconsumerForTable();
  //   List<SubConsumerT>? temp = re
  //       .map(
  //         (e) => SubConsumerT.fromMap(e),
  //       )
  //       .toList();
  //   subconsumerT = temp;
  //   notifyListeners();
  //   log('subconsumerT length = ${subconsumerT?.length}');
  // }

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
    getConsumerForTable();
    log('{$x}');
    return x;
  }

  Future<int> addSubonsumer(SubConsumer subconsumer) async {
    var x = await _dbModel.addSubonsumer(subconsumer);

    log('{$x}');
    return x;
  }

  Future<int> deleteConsumer(int id) async {
    var x = await _dbModel.deleteConsumer(id);
    getConsumerForTable();
    log('delete {$x}');
    return x;
  }
}
