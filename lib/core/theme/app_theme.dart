import 'package:flutter/material.dart';

class CafeColors {
  static const Color lightBg = Color(0xFFFBF7F2);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE8DDD2);
  static const Color lightTextPrimary = Color(0xFF2C1810);
  static const Color lightTextSecondary = Color(0xFF6B5344);
  static const Color lightTextMuted = Color(0xFFA08977);

  static const Color darkBg = Color(0xFF131110);
  static const Color darkSurface = Color(0xFF1E1B18);
  static const Color darkDivider = Color(0xFF2E2A25);
  static const Color darkTextPrimary = Color(0xFFF5EDE4);
  static const Color darkTextSecondary = Color(0xFFC4B5A5);
  static const Color darkTextMuted = Color(0xFF6B5E52);

  static const Color primary = Color(0xFFC8956C);
  static const Color primaryDark = Color(0xFFA67550);
  static const Color success = Color(0xFF5B8C5A);
  static const Color warning = Color(0xFFD4A04A);
  static const Color danger = Color(0xFFC45B4A);
  static const Color info = Color(0xFF5B8CA0);
  static const Color espresso = Color(0xFF2C1810);
  static const Color cream = Color(0xFFF5EDE4);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Vazirmatn',
    colorSchemeSeed: CafeColors.primary,
    scaffoldBackgroundColor: CafeColors.lightBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: CafeColors.lightBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: CafeColors.lightTextPrimary,
      ),
      iconTheme: IconThemeData(color: CafeColors.lightTextPrimary),
    ),
    cardTheme: CardThemeData(
      color: CafeColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: CafeColors.lightDivider),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CafeColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Vazirmatn',
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: CafeColors.primary,
        side: const BorderSide(color: CafeColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Vazirmatn',
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CafeColors.lightSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.lightDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.lightDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.danger),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Vazirmatn',
        color: CafeColors.lightTextMuted,
        fontSize: 14,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: CafeColors.lightSurface,
      selectedItemColor: CafeColors.primary,
      unselectedItemColor: CafeColors.lightTextMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontFamily: 'Vazirmatn', fontSize: 11),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: CafeColors.lightSurface,
      selectedColor: CafeColors.primary,
      labelStyle: const TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: const BorderSide(color: CafeColors.lightDivider),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    ),
    dividerColor: CafeColors.lightDivider,
    iconTheme: const IconThemeData(color: CafeColors.lightTextSecondary),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Vazirmatn',
    colorSchemeSeed: CafeColors.primaryDark,
    scaffoldBackgroundColor: CafeColors.darkBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: CafeColors.darkBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: CafeColors.darkTextPrimary,
      ),
      iconTheme: IconThemeData(color: CafeColors.darkTextPrimary),
    ),
    cardTheme: CardThemeData(
      color: CafeColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: CafeColors.darkDivider),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CafeColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Vazirmatn',
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: CafeColors.primaryDark,
        side: const BorderSide(color: CafeColors.primaryDark, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Vazirmatn',
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CafeColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.darkDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.darkDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: CafeColors.danger),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Vazirmatn',
        color: CafeColors.darkTextMuted,
        fontSize: 14,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: CafeColors.darkSurface,
      selectedItemColor: CafeColors.primaryDark,
      unselectedItemColor: CafeColors.darkTextMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontFamily: 'Vazirmatn', fontSize: 11),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: CafeColors.darkSurface,
      selectedColor: CafeColors.primaryDark,
      labelStyle: const TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: const BorderSide(color: CafeColors.darkDivider),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    ),
    dividerColor: CafeColors.darkDivider,
    iconTheme: const IconThemeData(color: CafeColors.darkTextSecondary),
  );
}