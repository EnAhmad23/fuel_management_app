import 'dart:developer';

import 'package:intl/intl.dart';

class Trip {
  final int? id;
  final String? subconName;
  int? recordBefor;
  int? recordAfter;
  int? distation;
  final String? status;
  final String? road;
  final String? cause;
  final DateTime? date;

  Trip(
      {this.id,
      required this.subconName,
      this.recordBefor,
      this.recordAfter,
      required this.status,
      required this.date,
      required this.road,
      required this.cause,
      this.distation});
  factory Trip.fromMap(Map<String, Object?> map) {
    log('id -> ${map['id']}');
    return Trip(
        id: int.parse('${map['id']}'),
        subconName: '${map['details']}',
        status: '${map['status']}',
        date:
            map['date'] != null ? DateTime.parse(map['date'].toString()) : null,
        road: map['road'] as String?,
        cause: map['cause'] as String?,
        recordBefor: int.parse('${map['recordBefore'] ?? 0}'),
        recordAfter: int.parse('${map['recordAfter'] ?? 0}'),
        distation: int.parse('${map['recordAfter'] ?? 0}') -
            int.parse('${map['recordBefore'] ?? 0}'));
  }
  String? get formattedDate {
    return date != null ? DateFormat('yyyy-MM-dd').format(date!) : null;
  }
}
