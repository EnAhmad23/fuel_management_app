class SubConsumer {
  int? id;
  final String consumerName;
  final String details;
  // final String consumerName;
  final String? description;
  // final int operationsCount;
  final bool? hasRcord;
  final int? record;
  final DateTime? date;
  // DBModel dbModel = DBModel();

  SubConsumer({
    this.date,
    this.record,
    this.id,
    required this.details,
    required this.description,
    required this.consumerName,
    required this.hasRcord,
  });
}
