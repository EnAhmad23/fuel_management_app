class AppConsumers {
  int? id;
  String? name;
  int? subConsumerCount;
  int? operationsCount;

  AppConsumers(
      {required this.name,
      required this.subConsumerCount,
      required this.operationsCount,
      required this.id});
  AppConsumers.formMap(Map<String, Object?> map) {
    AppConsumers(
        name: map['name'] as String?,
        subConsumerCount: map['subConsumerCount'] as int?,
        operationsCount: map['operationsCount'] as int?,
        id: map['id'] as int?);
  }
}
