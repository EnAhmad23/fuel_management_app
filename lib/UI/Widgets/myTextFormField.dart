import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {super.key,
      required this.labelText,
      this.obscureText,
      required this.hintText,
      required this.controller,
      this.validator});
  final String labelText;
  final String hintText;
  String? Function(String?)? validator;
  final TextEditingController controller;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            labelText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscureText ?? false,
          style: TextStyle(fontSize: 18.sp),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
