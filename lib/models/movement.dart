import 'package:intl/intl.dart';

class Movement {
  final int? record;
  final int? subId;
  final DateTime? date;
  final int id;

  Movement(
      {required this.subId,
      required this.id,
      required this.record,
      required this.date});
  factory Movement.fromMap(Map<String, Object?> map) {
    return Movement(
      id: int.parse('${map['id']}'),
      record: int.parse('${map['record']}'),
      date: map['date'] != null ? DateTime.parse(map['date'].toString()) : null,
      subId: int.parse('${map['sub_consumer_id']}'),
    );
  }

  String? get formattedDate {
    // ignore: unnecessary_null_comparison
    return date != null ? DateFormat('yyyy-MM-dd').format(date!) : null;
  }
}
