import 'package:intl/intl.dart';

class OperationT {
  int? id;
  String? subConsumerDetails;
  String? consumerName;
  String? receiverName;
  String? type;
  bool? checked;
  String? dischangeNumber;
  String? foulType;
  int? amount;
  DateTime? newDate;
  String? description;

  OperationT({
    this.id,
    required this.subConsumerDetails,
    required this.consumerName,
    required this.receiverName,
    required this.type,
    required this.checked,
    required this.dischangeNumber,
    required this.foulType,
    required this.amount,
    required this.newDate,
    required this.description,
  });

  factory OperationT.fromMap(Map<String, dynamic> e) {
    // DBModel().getConsumersName(subId)
    return OperationT(
      id: e['id'],
      subConsumerDetails: e['subConsumerDetails'].toString() == 'null'
          ? '_'
          : e['subConsumerDetails'].toString(),
      consumerName: e['consumerName'],
      receiverName: e['receiverName'],
      type: e['type'],
      checked: (int.parse(e['checked'].toString())) == 1,
      dischangeNumber: e['dischangeNumber'],
      foulType: e['foulType'],
      amount: int.tryParse(e['amount'].toString()) ?? 0,
      newDate: e['date'] != null ? DateTime.parse(e['date'].toString()) : null,
      description: e['description'],
    );
  }

  // Method to get the formatted date
  String? get formattedDate {
    return newDate != null ? DateFormat('yyyy-MM-dd').format(newDate!) : null;
  }
}
