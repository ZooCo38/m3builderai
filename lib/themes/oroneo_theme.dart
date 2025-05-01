import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OroneoTheme {
  // Méthode principale pour obtenir le thème selon le mode et le niveau de contraste
  static ThemeData getTheme({
    ThemeMode themeMode = ThemeMode.light,
    ContrastLevel contrastLevel = ContrastLevel.normal,
  }) {
    switch (themeMode) {
      case ThemeMode.light:
        switch (contrastLevel) {
          case ContrastLevel.normal:
            return _getLightTheme();
          case ContrastLevel.medium:
            return _getLightMediumContrastTheme();
          case ContrastLevel.high:
            return _getLightHighContrastTheme();
        }
      case ThemeMode.dark:
        switch (contrastLevel) {
          case ContrastLevel.normal:
            return _getDarkTheme();
          case ContrastLevel.medium:
            return _getDarkMediumContrastTheme();
          case ContrastLevel.high:
            return _getDarkHighContrastTheme();
        }
      default:
        return _getLightTheme();
    }
  }
  
  // Méthodes compatibles avec theme_controller.dart
  static ThemeData lightTheme(ThemeData base) {
    return _getLightTheme();
  }
  
  static ThemeData darkTheme(ThemeData base) {
    return _getDarkTheme();
  }
  
  // Thème clair standard
  static ThemeData _getLightTheme() {
    final colorScheme = ColorScheme.light(
      primary: Color(0xff030304),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1d1d1f),
      onPrimaryContainer: Color(0xff868587),
      secondary: Color(0xff5f5e5f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe2dfdf),
      onSecondaryContainer: Color(0xff646263),
      tertiary: Color(0xff040203),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff201c1e),
      onTertiaryContainer: Color(0xff8a8386),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      background: Color(0xfffdf8f8),
      onBackground: Color(0xff1c1b1b),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff1c1b1b),
      surfaceTint: Color(0xff5f5e60),
      surfaceVariant: Color(0xfff4f4f4),
      onSurfaceVariant: Color(0xff46464a),
      outline: Color(0xff77767b),
      outlineVariant: Color(0xffc7c6ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      onInverseSurface: Color(0xffe7e1e9),
      inversePrimary: Color(0xffc8c6c8),
      primaryFixed: Color(0xffe4e2e4),
      onPrimaryFixed: Color(0xff1b1b1d),
      primaryFixedDim: Color(0xffc8c6c8),
      onPrimaryFixedVariant: Color(0xff474649),
      secondaryFixed: Color(0xffe5e2e2),
      onSecondaryFixed: Color(0xff1c1b1c),
      secondaryFixedDim: Color(0xffc9c6c6),
      onSecondaryFixedVariant: Color(0xff474647),
      tertiaryFixed: Color(0xffe9e0e3),
      onTertiaryFixed: Color(0xff1e1a1c),
      tertiaryFixedDim: Color(0xffcdc4c7),
      onTertiaryFixedVariant: Color(0xff4b4548),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: createTextTheme(ThemeData.light().textTheme),
    );
  }
  
  // Thème clair avec contraste moyen
  static ThemeData _getLightMediumContrastTheme() {
    final colorScheme = ColorScheme.light(
      primary: Color(0xff030304),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1d1d1f),
      onPrimaryContainer: Color(0xffaaa8aa),
      secondary: Color(0xff373637),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6e6c6d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff040203),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff201c1e),
      onTertiaryContainer: Color(0xffaea6a9),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff111111),
      background: Color(0xfffdf8f8),
      onBackground: Color(0xff111111),
      surfaceTint: Color(0xff5f5e60),
      surfaceVariant: Color(0xfff2ecf4),
      onSurfaceVariant: Color(0xff36363a),
      outline: Color(0xff525256),
      outlineVariant: Color(0xff6d6c71),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      onInverseSurface: Color(0xffe7e1e9),
      inversePrimary: Color(0xffc8c6c8),
      primaryFixed: Color(0xffe4e2e4),
      onPrimaryFixed: Color(0xff1b1b1d),
      primaryFixedDim: Color(0xffc8c6c8),
      onPrimaryFixedVariant: Color(0xff474649),
      secondaryFixed: Color(0xffe5e2e2),
      onSecondaryFixed: Color(0xff1c1b1c),
      secondaryFixedDim: Color(0xffc9c6c6),
      onSecondaryFixedVariant: Color(0xff474647),
      tertiaryFixed: Color(0xffe9e0e3),
      onTertiaryFixed: Color(0xff1e1a1c),
      tertiaryFixedDim: Color(0xffcdc4c7),
      onTertiaryFixedVariant: Color(0xff4b4548),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffe0dcdc),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: createTextTheme(ThemeData.light().textTheme),
    );
  }
  
  // Thème clair avec contraste élevé
  static ThemeData _getLightHighContrastTheme() {
    final colorScheme = ColorScheme.light(
      primary: Color(0xFF27174E),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF493971),
      onPrimaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF27174E),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF493971),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: Color(0xFF420E24),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF6B2F45),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xFF440F0E),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFF6E2F2C),
      onErrorContainer: Color(0xFFFFFFFF),
      background: Color(0xFFFDF7FF),
      onBackground: Color(0xFF1D1B20),
      surface: Color(0xFFFDF7FF),
      onSurface: Color(0xFF000000),
      surfaceTint: Color(0xFF27174E),
      surfaceVariant: Color(0xFFF0EBF2),
      onSurfaceVariant: Color(0xFF3F3E40),
      outline: Color(0xFF726F73),
      outlineVariant: Color(0xFFB1ADB3),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF19191A),
      onInverseSurface: Color(0xFFE4DEE6),
      inversePrimary: Color(0xFF1B1037),
      primaryFixed: Color(0xFF493971),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFF3F2F67),
      onPrimaryFixedVariant: Color(0xFFBEB9CA),
      secondaryFixed: Color(0xFF493971),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF3F2F67),
      onSecondaryFixedVariant: Color(0xFFBEB9CA),
      tertiaryFixed: Color(0xFF6B2F45),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF5F253B),
      onTertiaryFixedVariant: Color(0xFFC6B7BD),
      surfaceDim: Color(0xFFF5F0F7),
      surfaceBright: Color(0xFFFDF7FF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF8F2FA),
      surfaceContainer: Color(0xFFF5F0F7),
      surfaceContainerHigh: Color(0xFFF0EBF2),
      surfaceContainerHighest: Color(0xFFEEE8F0),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: createTextTheme(ThemeData.light().textTheme),
    );
  }
  
  // Thème sombre standard
  static ThemeData _getDarkTheme() {
    final colorScheme = ColorScheme.dark(
      primary: Color(0xffc8c6c8),
      onPrimary: Color(0xff303032),
      primaryContainer: Color(0xff1d1d1f),
      onPrimaryContainer: Color(0xff868587),
      secondary: Color(0xffc9c6c6),
      onSecondary: Color(0xff313031),
      secondaryContainer: Color(0xff474647),
      onSecondaryContainer: Color(0xffb7b4b5),
      tertiary: Color(0xffcdc4c7),
      onTertiary: Color(0xff342f31),
      tertiaryContainer: Color(0xff201c1e),
      onTertiaryContainer: Color(0xff8a8386),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      background: Color(0xff141313),
      onBackground: Color(0xffe5e2e1),
      surfaceTint: Color(0xffc8c6c8),
      surfaceVariant: Color(0xff2e2e30),
      onSurfaceVariant: Color(0xffc7c6ca),
      outline: Color(0xff919095),
      outlineVariant: Color(0xff46464a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      onInverseSurface: Color(0xff48484a),
      inversePrimary: Color(0xff5f5e60),
      primaryFixed: Color(0xffe4e2e4),
      onPrimaryFixed: Color(0xff1b1b1d),
      primaryFixedDim: Color(0xffc8c6c8),
      onPrimaryFixedVariant: Color(0xff474649),
      secondaryFixed: Color(0xffe5e2e2),
      onSecondaryFixed: Color(0xff1c1b1c),
      secondaryFixedDim: Color(0xffc9c6c6),
      onSecondaryFixedVariant: Color(0xff474647),
      tertiaryFixed: Color(0xffe9e0e3),
      onTertiaryFixed: Color(0xff1e1a1c),
      tertiaryFixedDim: Color(0xffcdc4c7),
      onTertiaryFixedVariant: Color(0xff4b4548),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2b2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: createTextTheme(ThemeData.dark().textTheme),
    );
  }
  
  // Thème sombre avec contraste moyen
  static ThemeData _getDarkMediumContrastTheme() {
    final colorScheme = ColorScheme.dark(
      primary: Color(0xffdedbde),
      onPrimary: Color(0xff252527),
      primaryContainer: Color(0xff929092),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffdfdbdc),
      onSecondary: Color(0xff262526),
      secondaryContainer: Color(0xff929091),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe3dadd),
      onTertiary: Color(0xff292427),
      tertiaryContainer: Color(0xff968f91),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      background: Color(0xff141313),
      onBackground: Color(0xffffffff),
      surfaceTint: Color(0xffc8c6c8),
      surfaceVariant: Color(0xff27252a),
      onSurfaceVariant: Color(0xffdddbe0),
      outline: Color(0xffb2b1b6),
      outlineVariant: Color(0xff919094),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      onInverseSurface: Color(0xff48484a),
      inversePrimary: Color(0xff48484a),
      primaryFixed: Color(0xffe4e2e4),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc8c6c8),
      onPrimaryFixedVariant: Color(0xff111113),
      secondaryFixed: Color(0xffe5e2e2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc9c6c6),
      onSecondaryFixedVariant: Color(0xff111112),
      tertiaryFixed: Color(0xffe9e0e3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcdc4c7),
      onTertiaryFixedVariant: Color(0xff141012),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff515050),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff484646),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: createTextTheme(ThemeData.dark().textTheme),
    );
  }
  
  // Thème sombre avec contraste élevé
  // Thème sombre avec contraste élevé
  static ThemeData _getDarkHighContrastTheme() {
    final colorScheme = ColorScheme.dark(
      primary: Color(0xfff2eff2),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc4c2c4),
      onPrimaryContainer: Color(0xff0b0b0d),
      secondary: Color(0xfff3eff0),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc5c2c3),
      onSecondaryContainer: Color(0xff0b0b0c),
      tertiary: Color(0xfff7eef0),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc9c0c3),
      onTertiaryContainer: Color(0xff0e0a0c),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      background: Color(0xff141313),
      onBackground: Color(0xffffffff),
      surfaceTint: Color(0xffc8c6c8),
      surfaceVariant: Color(0xff27262a),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff1eff4),
      outlineVariant: Color(0xffc3c2c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      onInverseSurface: Color(0xff48484a),
      inversePrimary: Color(0xff48484a),
      primaryFixed: Color(0xffe4e2e4),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc8c6c8),
      onPrimaryFixedVariant: Color(0xff111113),
      secondaryFixed: Color(0xffe5e2e2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc9c6c6),
      onSecondaryFixedVariant: Color(0xff111112),
      tertiaryFixed: Color(0xffe9e0e3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcdc4c7),
      onTertiaryFixedVariant: Color(0xff141012),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff515050),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff484646),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: createTextTheme(ThemeData.dark().textTheme),
    );
  }
  
  // TextTheme avec Montserrat via Google Fonts
  static TextTheme createTextTheme(TextTheme base) {
    return GoogleFonts.montserratTextTheme(base).copyWith(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}

// Niveaux de contraste disponibles pour le thème
enum ContrastLevel { normal, medium, high }