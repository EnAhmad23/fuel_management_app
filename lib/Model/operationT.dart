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
      {required this.id,
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
  OperationT.formMap(Map<String, Object?> e) {
    OperationT(
        id: (e['id']) as int,
        subConsumerDetails: e['subConsumerDetails'] as String?,
        consumerName: e['consumerName'] as String?,
        receiverName: e['receiverName'] as String?,
        type: e['type'] as String?,
        checked: e['checked'] as bool?,
        dischangeNumber: e['dischangeNumber'] as String?,
        foulType: e['foulType'] as String?,
        amount: (e['amount'] as num).toDouble(),
        newDate: e['newDate'] as DateTime?,
        description: e['description'] as String?);
  }
}
