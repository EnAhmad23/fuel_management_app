import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {super.key, required this.icon, required this.iconColor, this.onTap});
  final Color iconColor;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: iconColor,
          size: 20.sp,
        ),
      ),
    );
  }
}
