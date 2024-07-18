import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    super.key,
    required this.labelText,
    this.obscureText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.fontSize,
    this.inputFormatters,
  });
  final String labelText;
  final TextInputType? keyboardType;
  final String hintText;
  String? Function(String?)? validator;
  final TextEditingController controller;
  bool? obscureText;
  double? fontSize;
  final List<TextInputFormatter>? inputFormatters;

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
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            inputFormatters: inputFormatters,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
            controller: controller,
            obscureText: obscureText ?? false,
            style: TextStyle(fontSize: fontSize ?? 18.sp),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
