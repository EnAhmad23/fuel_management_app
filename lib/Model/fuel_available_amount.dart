class FuelAvailableAmount {
  final String? fuelType;
  final int? amount;

  FuelAvailableAmount({required this.fuelType, required this.amount});

  factory FuelAvailableAmount.fromMap(Map<String, Object?> e) {
    return FuelAvailableAmount(
        fuelType: '${e['foulType']}',
        amount: int.parse('${e['net_amount'] ?? 0}'));
  }
}
