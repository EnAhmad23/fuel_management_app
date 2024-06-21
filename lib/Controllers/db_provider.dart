import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/Model/consumer.dart';

class DbProvider extends ChangeNotifier {
  // Database? database;
  final DBModel _dbModel = DBModel();
  List<AppConsumers>? list;
  TextEditingController nameController = TextEditingController();
  // DbProvider() {
  //   initDB();
  // }
  // initDB() async {
  //   database = await _dbModel.db;
  // }

  Future<int> addConsumer(String name) async {
    var x = await _dbModel.addConsumer(name);
    log('{$x}');
    return x;
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
      list = temp;
      notifyListeners();
      log(list?.length.toString() ?? '0');
      return list;
    } catch (e) {
      log('Error fetching data: $e');
      return null;
    }
  }
}
