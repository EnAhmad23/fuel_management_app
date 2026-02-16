class Operation {
  int? id;
  int? subConsumerId;
  double? amount;
  String? description;
  String? type;
  String? foulType;
  String? receiverName;
  String? dischangeNumber;
  String? date;
  int? checked;

  Operation({
    this.id,
    required this.subConsumerId,
    required this.amount,
    this.description,
    required this.type,
    required this.foulType,
    this.receiverName,
    this.dischangeNumber,
    this.date,
    this.checked = 0,
  });

  // Convert a Operation into a Map. The keys must correspond to the column names in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sub_consumer_id': subConsumerId,
      'amount': amount,
      'description': description,
      'type': type,
      'foulType': foulType,
      'receiverName': receiverName,
      'dischangeNumber': dischangeNumber,
      'date': date,
      'checked': checked,
    };
  }

  // Extract a Operation object from a Map.
  Operation.fromMap(Map<String, Object?> map) {
    Operation(
      id: map['id'] as int?,
      subConsumerId: map['sub_consumer_id'] as int,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String?,
      type: map['type'] as String,
      foulType: map['foulType'] as String,
      receiverName: map['receiverName'] as String?,
      dischangeNumber: map['dischangeNumber'] as String?,
      date: map['date'] as String?,
      checked: map['checked'] as int,
    );
  }
}
