import 'package:flutter/material.dart';

class AppColors {
  // Main palette
  static const Color primary = Color(0xFF1565C0); // Deep Blue
  static const Color primaryDark = Color(0xFF003C8F); // Navy
  static const Color accent = Color(0xFF42A5F5); // Bright Blue
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF5F7FA); // Light Gray
  static const Color error = Color(0xFFD32F2F); // Red
  static const Color success = Color(0xFF388E3C); // Green
  static const Color warning = Color(0xFFFFA000); // Orange
  static const Color info = Color(0xFF29B6F6); // Light Blue

  static const Color accentLight = Color(0xFFE3F2FD); // Light blue
  static const Color accentDark =
      Color(0xFF1565C0); // Deep blue (same as primary)
  static const Color warningDark = Color(0xFFF57C00); // Darker orange
  static const Color successDark = Color(0xFF2E7D32); // Darker green
  static const Color errorDark = Color(0xFFC62828); // Darker red

  // Text
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White
  static const Color textOnBackground = Color(0xFF212121); // Dark Gray

  // Icons & Buttons
  static const Color buttonText = textOnPrimary;
  static const Color icon = textOnPrimary;

  // Shadows
  static const Color cardShadow = Color(0x29000000); // 16% black
  static const Color sideMenuShadow = Color(0x2D000000); // 18% black
  static const Color sideMenuDark =
      Color(0xFF111827); // Very dark blue-gray for side menu

  // Special
  static const Color delete = error;
  static const Color deleteBackground = Color(0xFFD32F2F); // Red
  static const Color danger = error;
}
