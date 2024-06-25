class OperationT {
  int? id;
  String? subConsumerDetails;
  String? consumerName;
  String? receiverName;
  String? type;
  bool? checked;
  String? dischangeNumber;
  String? foulType;
  double? amount;
  DateTime? newDate;
  String? description;

  OperationT(
      {this.id,
      required this.subConsumerDetails,
      required this.consumerName,
      required this.receiverName,
      required this.type,
      required this.checked,
      required this.dischangeNumber,
      required this.foulType,
      required this.amount,
      required this.newDate,
      required this.description});
  OperationT.fromMap(Map<String, Object?> e) {
    OperationT(
        id: (e['id']) as int,
        subConsumerDetails: e['subConsumerDetails'] as String?,
        consumerName: e['consumerName'] as String?,
        receiverName: e['receiverName'] as String?,
        type: e['type'] as String?,
        checked: (int.parse(e['checked'].toString())) == 1 ? true : false,
        dischangeNumber: e['dischangeNumber'] as String?,
        foulType: e['foulType'] as String?,
        amount: double.tryParse(e['amount'].toString()) ?? 0,
        newDate: e['newDate'] as DateTime?,
        description: e['description'] as String?);
  }
}
