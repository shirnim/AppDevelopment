import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color successColor = Color(0xFF059669);
  static const Color successDark = Color(0xFF047857);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: cardBackground,
      foregroundColor: textPrimary,
      elevation: 1,
      shadowColor: borderColor,
    ),
    cardTheme: CardTheme(
      color: cardBackground,
      elevation: 2,
      shadowColor: borderColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: borderColor, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: const Color(0xFFFAFAFA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: successColor.withOpacity(0.1),
      labelStyle: const TextStyle(
        color: successColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      side: BorderSide(color: successColor.withOpacity(0.2)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        height: 1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.3,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimary,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textSecondary,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E293B),
      foregroundColor: Colors.white,
      elevation: 1,
    ),
  );
}