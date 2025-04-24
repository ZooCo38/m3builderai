import 'package:flutter/material.dart';

class OroneoTheme {
  // Couleurs principales
  static const Color primaryColor = Color(0xFFFF4081); // Rose/magenta
  static const Color secondaryColor = Color(0xFFFF9800); // Orange
  static const Color tertiaryColor = Color(0xFF4CAF50); // Vert
  
  // Couleurs de fond
  static const Color darkBackground = Color(0xFF121212); // Noir presque pur
  static const Color lightBackground = Color(0xFFFAFAFA); // Blanc cassé
  
  // Couleurs de texte
  static const Color darkTextColor = Color(0xFF121212);
  static const Color lightTextColor = Color(0xFFFFFFFF);
  
  // Couleurs d'accent
  static const Color accentColor = Color(0xFFFF4081); // Rose/magenta
  static const Color successColor = Color(0xFF4CAF50); // Vert
  static const Color warningColor = Color(0xFFFF9800); // Orange
  static const Color errorColor = Color(0xFFE53935); // Rouge
  
  // Dégradés
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient pinkGradient = LinearGradient(
    colors: [Color(0xFFFF4081), Color(0xFFC51162)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Thème sombre (par défaut)
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      background: darkBackground,
      surface: darkBackground.withOpacity(0.8),
      error: errorColor,
      onPrimary: lightTextColor,
      onSecondary: lightTextColor,
      onTertiary: lightTextColor,
      onBackground: lightTextColor,
      onSurface: lightTextColor,
      onError: lightTextColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: lightTextColor,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: darkBackground.withOpacity(0.6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: lightTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: darkBackground.withOpacity(0.3),
    ),
  );
  
  // Thème clair
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      background: lightBackground,
      surface: Colors.white,
      error: errorColor,
      onPrimary: lightTextColor,
      onSecondary: lightTextColor,
      onTertiary: lightTextColor,
      onBackground: darkTextColor,
      onSurface: darkTextColor,
      onError: lightTextColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: darkTextColor,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: lightTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),
  );
}