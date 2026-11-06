import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    /// Background
    scaffoldBackgroundColor: AppColor.background,
    primaryColor: AppColor.primaryColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,
      surface: AppColor.surface,
      error: AppColor.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColor.bodyColor,
      onError: Colors.white,
    ),

    /// AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.background,
      foregroundColor: AppColor.bodyColor,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: Styles.textStyle(
        color: AppColor.bodyColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: const IconThemeData(color: AppColor.bodyColor),
    ),

    /// Cards
    cardColor: AppColor.surface,

    cardTheme: CardThemeData(
      color: AppColor.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      margin: EdgeInsets.zero,
    ),

    dividerColor: AppColor.dividerColor,

    /// Text Theme
    textTheme: TextTheme(
      displayLarge: Styles.textStyle(
        color: AppColor.bodyColor,
        fontSize: 34,
        fontWeight: FontWeight.w800,
      ),

      headlineLarge: Styles.textStyle(
        color: AppColor.bodyColor,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),

      titleLarge: Styles.textStyle(
        color: AppColor.bodyColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),

      titleMedium: Styles.textStyle(
        color: AppColor.bodyColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),

      bodyLarge: Styles.textStyle(color: AppColor.bodyColor, fontSize: 16),

      bodyMedium: Styles.textStyle(color: AppColor.subtitleColor, fontSize: 15),

      bodySmall: Styles.textStyle(color: AppColor.hintColor, fontSize: 13),

      labelLarge: Styles.textStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),

    /// Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: Styles.textStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    /// Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.primaryColor,
        minimumSize: const Size(double.infinity, 56),
        side: const BorderSide(color: AppColor.borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    /// Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.primaryColor,
        textStyle: Styles.textStyle(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    /// Input Field
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      hintStyle: Styles.textStyle(color: AppColor.hintColor),

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColor.borderColor),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColor.primaryColor, width: 1.6),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColor.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColor.error, width: 1.6),
      ),
    ),

    /// Floating Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    /// Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.subtitleColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    /// Checkbox
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),

    /// Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) => Colors.white),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColor.secondaryColor
            : AppColor.borderColor,
      ),
    ),
  );
}
