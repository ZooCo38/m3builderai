import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OroneoTheme {
  // Couleurs Oroneo
  static const Color primaryColor = Color(0xFF65558F); // Violet Oroneo
  static const Color secondaryColor = Color(0xFF6C5B7B);
  static const Color tertiaryColor = Color(0xFF8A7AAF);
  
  // Schéma de couleurs clair
  static ColorScheme lightColorScheme = ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    // Autres couleurs si nécessaire
  );
  
  // Schéma de couleurs sombre
  static ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    // Autres couleurs si nécessaire
  );
  
  // TextTheme avec Montserrat via Google Fonts
  static TextTheme createTextTheme(TextTheme base) {
    return GoogleFonts.montserratTextTheme(base);
  }
  
  // Thème clair
  static ThemeData lightTheme(ThemeData base) {
    return base.copyWith(
      colorScheme: lightColorScheme,
      textTheme: createTextTheme(base.textTheme),
      // Autres personnalisations si nécessaire
    );
  }
  
  // Thème sombre
  static ThemeData darkTheme(ThemeData base) {
    return base.copyWith(
      colorScheme: darkColorScheme,
      textTheme: createTextTheme(base.textTheme),
      // Autres personnalisations si nécessaire
    );
  }
}