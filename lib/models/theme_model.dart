import 'package:flutter/material.dart';

class ThemeModel {
  // Couleurs primaires
  Color primary = const Color(0xFF6750A4);
  Color onPrimary = const Color(0xFFFFFFFF);
  Color primaryContainer = const Color(0xFFEADDFF);
  Color onPrimaryContainer = const Color(0xFF21005D);
  
  // Couleurs secondaires
  Color secondary = const Color(0xFF625B71);
  Color onSecondary = const Color(0xFFFFFFFF);
  Color secondaryContainer = const Color(0xFFE8DEF8);
  Color onSecondaryContainer = const Color(0xFF1D192B);
  
  // Couleurs tertiaires
  Color tertiary = const Color(0xFF7D5260);
  Color onTertiary = const Color(0xFFFFFFFF);
  Color tertiaryContainer = const Color(0xFFFFD8E4);
  Color onTertiaryContainer = const Color(0xFF31111D);
  
  // Couleurs d'erreur
  Color error = const Color(0xFFB3261E);
  Color onError = const Color(0xFFFFFFFF);
  Color errorContainer = const Color(0xFFF9DEDC);
  Color onErrorContainer = const Color(0xFF410E0B);
  
  // Couleurs de fond et de surface
  Color background = const Color(0xFFFFFBFE);
  Color onBackground = const Color(0xFF1C1B1F);
  Color surface = const Color(0xFFFFFBFE);
  Color onSurface = const Color(0xFF1C1B1F);
  
  // Constructeur par défaut
  ThemeModel();
  
  // Constructeur de copie
  ThemeModel.copy(ThemeModel other) {
    primary = other.primary;
    onPrimary = other.onPrimary;
    primaryContainer = other.primaryContainer;
    onPrimaryContainer = other.onPrimaryContainer;
    secondary = other.secondary;
    onSecondary = other.onSecondary;
    secondaryContainer = other.secondaryContainer;
    onSecondaryContainer = other.onSecondaryContainer;
    tertiary = other.tertiary;
    onTertiary = other.onTertiary;
    tertiaryContainer = other.tertiaryContainer;
    onTertiaryContainer = other.onTertiaryContainer;
    error = other.error;
    onError = other.onError;
    errorContainer = other.errorContainer;
    onErrorContainer = other.onErrorContainer;
    background = other.background;
    onBackground = other.onBackground;
    surface = other.surface;
    onSurface = other.onSurface;
  }
  
  // Méthode pour créer un thème à partir d'une couleur de base
  static ThemeModel fromSeed(Color seedColor) {
    // Cette méthode pourrait utiliser ColorScheme.fromSeed pour générer un schéma de couleurs
    // Pour l'instant, nous retournons simplement un thème par défaut
    return ThemeModel();
  }
  
  // Méthode pour convertir en Map (utile pour la sérialisation)
  Map<String, dynamic> toMap() {
    return {
      'primary': primary.value,
      'onPrimary': onPrimary.value,
      'primaryContainer': primaryContainer.value,
      'onPrimaryContainer': onPrimaryContainer.value,
      'secondary': secondary.value,
      'onSecondary': onSecondary.value,
      'secondaryContainer': secondaryContainer.value,
      'onSecondaryContainer': onSecondaryContainer.value,
      'tertiary': tertiary.value,
      'onTertiary': onTertiary.value,
      'tertiaryContainer': tertiaryContainer.value,
      'onTertiaryContainer': onTertiaryContainer.value,
      'error': error.value,
      'onError': onError.value,
      'errorContainer': errorContainer.value,
      'onErrorContainer': onErrorContainer.value,
      'background': background.value,
      'onBackground': onBackground.value,
      'surface': surface.value,
      'onSurface': onSurface.value,
    };
  }
  
  // Méthode pour créer à partir d'une Map (utile pour la désérialisation)
  static ThemeModel fromMap(Map<String, dynamic> map) {
    final theme = ThemeModel();
    
    theme.primary = Color(map['primary'] as int);
    theme.onPrimary = Color(map['onPrimary'] as int);
    theme.primaryContainer = Color(map['primaryContainer'] as int);
    theme.onPrimaryContainer = Color(map['onPrimaryContainer'] as int);
    theme.secondary = Color(map['secondary'] as int);
    theme.onSecondary = Color(map['onSecondary'] as int);
    theme.secondaryContainer = Color(map['secondaryContainer'] as int);
    theme.onSecondaryContainer = Color(map['onSecondaryContainer'] as int);
    theme.tertiary = Color(map['tertiary'] as int);
    theme.onTertiary = Color(map['onTertiary'] as int);
    theme.tertiaryContainer = Color(map['tertiaryContainer'] as int);
    theme.onTertiaryContainer = Color(map['onTertiaryContainer'] as int);
    theme.error = Color(map['error'] as int);
    theme.onError = Color(map['onError'] as int);
    theme.errorContainer = Color(map['errorContainer'] as int);
    theme.onErrorContainer = Color(map['onErrorContainer'] as int);
    theme.background = Color(map['background'] as int);
    theme.onBackground = Color(map['onBackground'] as int);
    theme.surface = Color(map['surface'] as int);
    theme.onSurface = Color(map['onSurface'] as int);
    
    return theme;
  }
}