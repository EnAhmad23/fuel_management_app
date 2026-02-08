// Clean, reusable, and aligned refactor
// ---------------------------------
// Focus:
// 1. No scrolling on desktop
// 2. Reusable widgets
// 3. Clean spacing & alignment

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/views/Widgets/My_dropdown.dart';
import 'package:fuel_management_app/views/Widgets/custom_switch.dart';
import 'package:fuel_management_app/views/Widgets/myTextFormField.dart';
import 'package:fuel_management_app/views/Widgets/my_button.dart';

class UpdateOperationEstrad extends StatelessWidget {
  const UpdateOperationEstrad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text('تعديل عملية وارد'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GetBuilder<OpController>(
              builder: (op) {
                return Form(
                  key: op.formKey,
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Header(),
                        SizedBox(height: 20),
                        _MainFormRow(),
                        SizedBox(height: 16),
                        CustomSwitch(),
                        SizedBox(height: 16),
                        _DescriptionField(),
                        Spacer(),
                        _SubmitButton(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- HEADER ----------------
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'تعديل عملية وارد',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ---------------- MAIN ROW ----------------
class _MainFormRow extends StatelessWidget {
  const _MainFormRow();

  @override
  Widget build(BuildContext context) {
    final op = Get.find<OpController>();

    return Row(
      children: [
        Expanded(child: _DateField(op: op)),
        SizedBox(width: 12.w),
        Expanded(child: _AmountField(op: op)),
        SizedBox(width: 12.w),
        Expanded(child: _FuelTypeDropdown(op: op)),
      ],
    );
  }
}

// ---------------- DATE FIELD ----------------
class _DateField extends StatelessWidget {
  final OpController op;
  const _DateField({required this.op});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('التاريخ'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: op.dateCon,
          validator: op.dateValidet,
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            op.setDate(date);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ],
    );
  }
}

// ---------------- AMOUNT FIELD ----------------
class _AmountField extends StatelessWidget {
  final OpController op;
  const _AmountField({required this.op});

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      controller: op.amountCon,
      labelText: 'الكمية',
      hintText: 'أدخل كمية الوقود',
      fontSize: 16,
      validator: op.amontValidet,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}

// ---------------- FUEL TYPE ----------------
class _FuelTypeDropdown extends StatelessWidget {
  final OpController op;
  const _FuelTypeDropdown({required this.op});

  @override
  Widget build(BuildContext context) {
    return MyDropdown(
      lable: 'نوع الوقود',
      itemsList: const ['اختر نوع الوقود', 'بنزين', 'سولار'],
      value: op.fuelType ?? 'اختر نوع الوقود',
      validator: op.fuelTypeValidator,
      onchanged: (value) {
        op.setFuelType(value == 'اختر نوع الوقود' ? null : value);
      },
    );
  }
}

// ---------------- DESCRIPTION ----------------
class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    final op = Get.find<OpController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('وصف'),
        SizedBox(height: 6.h),
        TextField(
          controller: op.description,
          maxLines: 2,
          textAlign: TextAlign.right,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'أدخل الوصف...',
          ),
        ),
      ],
    );
  }
}

// ---------------- SUBMIT ----------------
class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final op = Get.find<OpController>();

    return Align(
      alignment: Alignment.centerRight,
      child: MyButton(
        text: 'تعديل',
        onTap: op.onTopUpdateWared,
      ),
    );
  }
}
