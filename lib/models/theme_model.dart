import 'package:flutter/material.dart';

// Ajouter ces propriétés au ThemeModel si elles n'existent pas déjà
class ThemeModel {
  // Propriétés de couleur principales
  Color primary = Colors.blue;
  Color onPrimary = Colors.white;
  Color primaryContainer = Colors.blue.shade100;
  Color onPrimaryContainer = Colors.blue.shade900;
  
  // Propriétés de couleur secondaires
  Color secondary = Colors.teal;
  Color onSecondary = Colors.white;
  Color secondaryContainer = Colors.teal.shade100;
  Color onSecondaryContainer = Colors.teal.shade900;
  
  // Propriétés de couleur tertiaires
  Color tertiary = Colors.amber;
  Color onTertiary = Colors.black;
  Color tertiaryContainer = Colors.amber.shade100;
  Color onTertiaryContainer = Colors.amber.shade900;
  
  // Propriétés de couleur d'erreur
  Color error = Colors.red;
  Color onError = Colors.white;
  Color errorContainer = Colors.red.shade100;
  Color onErrorContainer = Colors.red.shade900;
  
  // Propriétés de couleur de fond
  Color background = Colors.white;
  Color onBackground = Colors.black;
  
  // Propriétés de couleur de surface
  Color surface = Colors.white;
  Color onSurface = Colors.black;
  Color surfaceVariant = Colors.grey.shade100;
  Color onSurfaceVariant = Colors.grey.shade800;
  
  // Propriétés de couleur d'outline
  Color outline = Colors.grey.shade400;
  Color outlineVariant = Colors.grey.shade200;
  
  // Nouvelles propriétés pour Material 3
  Color surfaceContainer = Colors.grey.shade200;
  Color surfaceContainerLow = Colors.grey.shade100;
  Color surfaceContainerHigh = Colors.grey.shade300;
  Color surfaceContainerHighest = Colors.grey.shade400;
  Color surfaceBright = Colors.white;
  Color surfaceDim = Colors.grey.shade50;
  Color elevation = Colors.black12;
  
  // Méthode pour créer un ColorScheme à partir du modèle
  // Propriétés pour les nouvelles couleurs
  Color shadow = Colors.black.withOpacity(0.3);
  Color scrim = Colors.black.withOpacity(0.5);
  Color inverseSurface = Colors.white;
  Color onInverseSurface = Colors.black;
  Color inversePrimary = Colors.blue;
  
  // Assurez-vous que la méthode toColorScheme inclut ces nouvelles propriétés
  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      // Remplacer ces valeurs par les propriétés de la classe
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
    );
  }
}