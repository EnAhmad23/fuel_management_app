import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Model/fuel_available_amount.dart';

class FuelAmountTable extends StatelessWidget {
  const FuelAmountTable({super.key, required this.fuelTypes});
  final List<FuelAvailableAmount> fuelTypes;

  @override
  Widget build(BuildContext context) {
    return (fuelTypes.isEmpty)
        ? Center(
            child: SizedBox(
                height: 300.h,
                width: 600.h,
                child: Lottie.asset('assets/warning.json')),
          )
        : Consumer<OpProvider>(builder: (context, opPro, x) {
            return DataTable(
              decoration: const BoxDecoration(color: Colors.white),
              border: const TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey),
                outside: BorderSide(color: Colors.grey),
              ),
              columns: const [
                DataColumn(
                    label: Center(
                  child: Text('الكمية المتوفرة (لتر)',
                      textAlign: TextAlign.center),
                )),
                DataColumn(
                    label: Center(
                        child:
                            Text('نوع الوقود', textAlign: TextAlign.center))),
                DataColumn(label: Center(child: Text('#'))),
              ],
              rows: fuelTypes.map((fuelType) {
                return DataRow(cells: [
                  DataCell(Center(
                      child: Text('${fuelType.amount}',
                          textAlign: TextAlign.center))),
                  DataCell(Center(
                    child: Text('${fuelType.fuelType}',
                        textAlign: TextAlign.center),
                  )),
                  DataCell(Center(
                    child: Text('${fuelTypes.indexOf(fuelType) + 1}',
                        textAlign: TextAlign.center),
                  )),
                ]);
              }).toList(),
            );
          });
  }
}
