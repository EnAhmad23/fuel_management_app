import 'package:fuel_management_app/Model/DBModel.dart';

class SubConsumer {
  final int id;
  final int consumerId;
  final String details;
  // final String consumerName;
  final String? description;
  // final int operationsCount;
  final bool hasRecord;
  // DBModel dbModel = DBModel();

  SubConsumer(
      {required this.details,
      required this.description,
      required this.hasRecord,
      required this.id,
      required this.consumerId});
}
