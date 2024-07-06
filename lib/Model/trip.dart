import 'package:intl/intl.dart';

class Trip {
  final String? subconName;
  final int? recordBefor;
  final int? recordAfter;
  final String? status;
  final String? road;
  final String? cause;
  final DateTime? date;

  Trip({
    required this.subconName,
    this.recordBefor,
    this.recordAfter,
    required this.status,
    required this.date,
    required this.road,
    required this.cause,
  });
  factory Trip.fromMap(Map<String, Object?> map) {
    return Trip(
        subconName: '${map['details']}',
        status: map['status'] as String,
        date:
            map['date'] != null ? DateTime.parse(map['date'].toString()) : null,
        road: map['road'] as String?,
        cause: map['cause'] as String?);
  }
  String? get formattedDate {
    return date != null ? DateFormat('yyyy-MM-dd').format(date!) : null;
  }
}
