class FuelAvailableAmount {
  final String? fuelType;
  double? amount;

  FuelAvailableAmount({required this.fuelType, required this.amount});

  factory FuelAvailableAmount.fromMap(Map<String, Object?> e) {
    return FuelAvailableAmount(
        fuelType: '${e['foulType']}',
        amount: double.parse('${e['net_amount'] ?? 0}'));
  }
}
