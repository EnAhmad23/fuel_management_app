import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePageCard extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final IconData icon;
  final String mainText;
  final String subText;
  final dynamic toPage;
  const HomePageCard({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.mainText,
    required this.subText,
    required this.textColor,
    required this.iconColor,
    this.toPage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 150.h, // Set a fixed height
        width: 253.w, // Set width based on your design needs
        // padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // Wrap your Column with Expanded
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      icon,
                      size: 120.0.sp,
                      color: iconColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            mainText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: textColor),
                          ),
                          Text(
                            subText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  // Handle link press
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.h),
                  color: iconColor,
                  child: InkWell(
                    onTap: () {
                      Get.to(toPage);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_circle_left,
                          color: textColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.0.w),
                        Text(
                          'عرض المزيد',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
