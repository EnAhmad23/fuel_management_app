class SubConsumer {
  int? id;
  final String consumerName;
  final String details;
  // final String consumerName;
  final String? description;
  // final int operationsCount;
  final bool? hasRcord;
  // DBModel dbModel = DBModel();

  SubConsumer({
    required this.details,
    required this.description,
    required this.consumerName,
    required this.hasRcord,
  });
}
