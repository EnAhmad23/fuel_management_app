import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {super.key,
      required this.labelText,
      this.obscureText,
      required this.hintText});
  final String labelText;
  final String hintText;
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
