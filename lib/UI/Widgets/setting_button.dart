import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.iconColor,
      required this.topLiftRadius,
      required this.topRightRadius,
      this.onTap});
  final Color color;
  final Color iconColor;
  final IconData icon;
  final double topLiftRadius;
  final double topRightRadius;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(topRightRadius),
              left: Radius.circular(topLiftRadius))),
      child: Center(
        child: IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
