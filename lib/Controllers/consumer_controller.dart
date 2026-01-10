import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fuel_management_app/models/DBModel.dart';
import 'package:fuel_management_app/models/consumer.dart';
import 'package:get/get.dart';

class ConController extends GetxController {
  // Database? database;
  final DBModel _dbModel = DBModel();

  List<AppConsumers>? consumers;

  TextEditingController consumerNameController = TextEditingController();
  // DbProvider() {
  //   initDB();
  // }
  // initDB() async {
  //   database = await _dbModel.db;
  // }

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
      update();
      return consumers;
    } catch (e) {
      log('Error fetching data: $e');
      return null;
    }
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

  Future<int> addConsumer(String name) async {
    var x = await _dbModel.addConsumer(name);
    log('{$x}');
    return x;
  }
}
