import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color primaryColor = Color(0xFF0A66C2); // LinkedIn Blue
  static const Color primaryDark = Color(0xFF004182);
  static const Color successColor = Color(0xFF059669);
  static const Color successDark = Color(0xFF047857);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFDC2626);
  static const Color backgroundColor = Color(0xFFF3F2EF); // Light background
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121); // Dark text
  static const Color textSecondary = Color(0xFF666666); // Medium text
  static const Color textTertiary = Color(0xFF888888); // Light text
  static const Color borderColor = Color(0xFFE1E1E1);
  static const Color dividerColor = Color(0xFFF1F5F9);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryDark],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [successColor, successDark],
  );

  // Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
  

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: successColor,
      surface: surfaceColor,
      background: backgroundColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceColor,
      foregroundColor: primaryColor, // LinkedIn blue for icons and text
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: borderColor,
      titleTextStyle: TextStyle(
        color: textPrimary, // Dark text for title
        fontSize: 18, // Slightly smaller title
        fontWeight: FontWeight.w700, // Bolder title
        fontFamily: 'Inter',
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // More subtle border radius
        side: const BorderSide(color: borderColor, width: 1),
      ), // Subtle border
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Reduced vertical padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Square corners
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600, // Semibold
          fontFamily: 'Inter',
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder( // Same style as elevated button
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600, // Semibold
          fontFamily: 'Inter',
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Square corners
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder( // Subtle border
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder( // Subtle border
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder( // Primary color on focus
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4), // Error color on error
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(
        color: textTertiary,
        fontSize: 14, // Smaller hint text
        fontWeight: FontWeight.w400,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF0F9FF),
      labelStyle: const TextStyle(
        color: primaryDark, // Darker primary for chip text
        fontWeight: FontWeight.w600, // Semibold
        fontSize: 12, // Slightly smaller
      ),
      shape: RoundedRectangleBorder(
        // Rounded pill shape
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textTertiary,
      type: BottomNavigationBarType.fixed, // Fixed type
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      // Display styles (less common in typical app UIs)
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700, // Bold
        color: textPrimary,
        height: 1.2,
        fontFamily: 'Inter',
      ),
      displayMedium: TextStyle(
        fontSize: 28, // Bold
        fontWeight: FontWeight.w700,
        color: textPrimary,
        height: 1.2,
        fontFamily: 'Inter',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700, // Bold
        color: textPrimary,
        height: 1.3,
        fontFamily: 'Inter',
      ),
      
      // Headline styles (for main titles and sections)
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700, // Bold
        color: textPrimary,
        height: 1.3,
        fontFamily: 'Inter',
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700, // Bold
        color: textPrimary,
        height: 1.3,
        fontFamily: 'Inter',
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700, // Bold
        color: textPrimary,
        height: 1.3,
        fontFamily: 'Inter',
      ),
      
      // Title styles (for subtitles and card titles)
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600, // Semibold
        color: textPrimary,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600, // Semibold
        color: textPrimary,
        fontFamily: 'Inter',
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600, // Semibold
        color: textPrimary,
        fontFamily: 'Inter',
      ),
      
      // Body styles (for paragraph text)
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.6,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.6,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textTertiary,
        height: 1.5,
        fontFamily: 'Inter',
      ),
      // Label styles (for small labels and captions)
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        fontFamily: 'Inter',
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: textTertiary,
        fontFamily: 'Inter',
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: textSecondary, // Use secondary text color for icons
      size: 24,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
      space: 1,
    ),

    fontFamily: 'Inter', // Using Inter as a clean, modern sans-serif font
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    fontFamily: 'Inter',
  );
}