import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  /// ===========================================================
  /// BRAND COLORS
  /// ===========================================================

  /// Primary (Logo Purple)
  static const Color primaryColor = Color(0xFF8B42F0);

  /// Lighter Primary
  static const Color primaryLight = Color(0xFFAB6FF2);

  /// Dark Primary
  static const Color primaryDark = Color(0xFF7B32CA);

  /// Accent / Secondary (Soft Lavender)
  static const Color secondaryColor = Color(0xFFBB85F4);

  /// Lighter Secondary
  static const Color secondaryLight = Color(0xFFE3CEF6);

  /// Dark Secondary
  static const Color secondaryDark = Color(0xFF9E5AF2);

  /// ===========================================================
  /// LIGHT MODE
  /// ===========================================================

  static const Color lightBackground = Color(0xFFFCFAFF);

  static const Color lightSurface = Color(0xFFF7F2FC);

  static const Color lightText = Color(0xFF2D2038);

  static const Color lightText54 = Color(0xFF756B7D);

  static const Color lightPrimary = primaryColor;

  /// ===========================================================
  /// BACKGROUND
  /// ===========================================================

  static const Color background = Color(0xFFFBF9FE);

  static const Color surface = Color(0xFFFFFFFF);

  static const Color surfaceLight = Color(0xFFF4ECFB);

  /// Splash Bottom
  static const Color splashBottom = Color(0xFF7B32CA);

  /// ===========================================================
  /// TEXT
  /// ===========================================================

  static const Color bodyColor = Color(0xFF2D2038);

  static const Color subtitleColor = Color(0xFF756B7D);

  static const Color hintColor = Color(0xFFB5A9BD);

  static const Color bodyWhite = Colors.white;

  /// ===========================================================
  /// BORDER
  /// ===========================================================

  static const Color borderColor = Color(0xFFE8D9F5);

  static const Color dividerColor = Color(0xFFF0EAF5);

  /// ===========================================================
  /// STATUS
  /// ===========================================================

  static const Color success = Color(0xFF22C55E);

  static const Color warning = Color(0xFFFFB547);

  static const Color error = Color(0xFFE5484D);

  /// ===========================================================
  /// GRADIENTS
  /// ===========================================================

  /// Splash
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFAB6FF2), Color(0xFF914DEE), Color(0xFF7B32CA)],
  );

  /// Primary Button
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF9E5AF2), Color(0xFF8B42F0)],
  );

  /// Secondary Button
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFE3CEF6), Color(0xFFBB85F4)],
  );

  /// Brand Gradient
  static const LinearGradient appGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFAB6FF2), Color(0xFF8B42F0), Color(0xFF7B32CA)],
  );

  /// ===========================================================
  /// BASIC
  /// ===========================================================

  static const Color white = Colors.white;

  static const Color black = Colors.black;

  static const Color grey = Colors.grey;

  static const Color red = Colors.red;

  static const Color transparent = Colors.transparent;
}
