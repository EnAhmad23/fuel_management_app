import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.iconColor,
      required this.topLiftRadius,
      required this.topRightRadius});
  final Color color;
  final Color iconColor;
  final IconData icon;
  final double topLiftRadius;
  final double topRightRadius;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(topRightRadius),
                left: Radius.circular(topLiftRadius))),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
