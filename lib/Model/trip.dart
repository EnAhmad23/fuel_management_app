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
}
