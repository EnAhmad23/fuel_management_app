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
  factory SubConsumerT.fromMap(Map<String, Object?> map) {
    return SubConsumerT(
        details: map['details'] as String,
        description: map['description'] as String,
        id: int.parse('${map['id']}'),
        consumerName: map['consumerName'] as String,
        numOfOP: int.parse('${map['numberOfOperations']}'));
  }
}
