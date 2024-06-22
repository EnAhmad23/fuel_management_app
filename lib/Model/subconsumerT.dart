class SubConsumerT {
  int? id;
  String? consumerName;
  String? details;
  // final String consumerName;
  String? description;
  // final int operationsCount;
  int? numOfOP;
  // DBModel dbModel = DBModel();

  SubConsumerT({
    required this.details,
    required this.description,
    required this.id,
    required this.consumerName,
    required this.numOfOP,
  });
  SubConsumerT.fromMap(Map<String, Object?> map) {
    SubConsumerT(
        details: map['subconsumer_details'] as String,
        description: map['subconsumer_description'] as String,
        id: int.parse(map['consumer_id'] as String),
        consumerName: map['consumer_name'] as String,
        numOfOP: map['number_of_operations'] as int);
  }
}
