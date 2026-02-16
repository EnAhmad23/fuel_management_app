import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constant/app_colors.dart';

class HomePageCard extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final IconData icon;
  final String mainText;
  final String subText;
  final String? unitText;
  final void Function()? onPress;
  const HomePageCard({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.mainText,
    required this.subText,
    required this.textColor,
    required this.iconColor,
    this.unitText,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 220.w,
        // Remove fixed or min/max height for better responsiveness
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          gradient: LinearGradient(
            colors: [
              backgroundColor.withAlpha(220),
              backgroundColor.withAlpha(120),
              AppColors.background.withAlpha(80)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withAlpha(60),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: AppColors.background.withOpacity(0.7),
              blurRadius: 8,
              offset: const Offset(-4, -4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Large, semi-transparent icon as watermark
            Positioned(
              left: -10,
              bottom: -10,
              child: Icon(
                icon,
                size: 110,
                color: backgroundColor.withAlpha(30),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon in a glassy circle
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: backgroundColor.withAlpha(60),
                            blurRadius: 12.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            AppColors.background.withOpacity(0.8),
                            backgroundColor.withOpacity(0.18)
                          ],
                        ),
                      ),
                      child: Icon(icon,
                          color: iconColor ?? backgroundColor, size: 28.sp),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Main value and unit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (unitText != null && unitText!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            unitText!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                          ),
                        ),
                      Flexible(
                        child: Text(
                          mainText,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.sp,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // Label
                  Expanded(
                    child: Text(
                      subText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Floating action button
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 36.h,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: FloatingActionButton.extended(
                          heroTag: null,
                          backgroundColor: backgroundColor,
                          foregroundColor: textColor,
                          elevation: 2,
                          onPressed: onPress,
                          icon: Icon(Icons.add, size: 18.sp, color: textColor),
                          label: Text(
                            'عرض المزيد',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                          ),
                          extendedPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
