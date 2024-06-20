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
  String? newDate;

  OperationT({
    required this.id,
    required this.subConsumerDetails,
    required this.consumerName,
    required this.receiverName,
    required this.type,
    required this.checked,
    required this.dischangeNumber,
    required this.foulType,
    required this.amount,
    required this.newDate,
  });
  OperationT.formMap(List<Map<String, Object?>> list) {
    list.map(
      (e) {
        id = (e['id']) as int;
        subConsumerDetails = e['subConsumerDetails'] as String?;
        consumerName = e['consumerName'] as String?;
        receiverName = e['receiverName'] as String?;
        type = e['type'] as String?;
        checked = e['checked'] as bool?;
        dischangeNumber = e['dischangeNumber'] as String?;
        foulType = e['foulType'] as String?;
        amount = e['amount'] as int;
        newDate = e['newDate'] as String?;
      },
    );
  }
}
