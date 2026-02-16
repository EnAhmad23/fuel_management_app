import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/Controllers/op_controller.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Aligning the row to the start
      children: [
        Text(
          'تحت المراجعة',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold), // Customize the style as needed
        ),
        SizedBox(
          width: 10.w,
        ),
        GetBuilder<OpController>(
          init: Get.find<OpController>(),
          builder: (provider) {
            return Checkbox(
              value: provider.checked ?? false,
              onChanged: (value) => provider.changeCheck(value),
            );
          },
        )
      ],
    );
  }
}
