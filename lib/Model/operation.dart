class Operation {
  final int id;
  final String subConsumerDetails;
  final String consumerName;
  final String receiverName;
  final String type;
  final bool checked;
  final String dischangeNumber;
  final String foulType;
  final int amount;
  final String newDate;

  Operation({
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
}
