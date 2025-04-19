import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/theme_model.dart';
import '../utils/platform_helper.dart';
import 'theme_controller.dart';

class ThemeImporter {
  static Future<bool> importTheme(
    String content,
    String format,
    ThemeController themeController,
  ) async {
    try {
      switch (format) {
        case 'json':
          final Map<String, dynamic> themeData = jsonDecode(content);
          
          // Importer chaque modèle de thème
          if (themeData.containsKey('lightStandard')) {
            _applyThemeFromMap(themeData['lightStandard'], themeController.currentThemeModel);
          }
          
          if (themeData.containsKey('darkStandard') && themeData['darkStandard'] != null) {
            _applyThemeFromMap(themeData['darkStandard'], themeController.darkThemeModel);
          }
          
          if (themeData.containsKey('lightMedium') && themeData['lightMedium'] != null) {
            _applyThemeFromMap(themeData['lightMedium'], themeController.lightMediumContrastModel);
          }
          
          if (themeData.containsKey('lightHigh') && themeData['lightHigh'] != null) {
            _applyThemeFromMap(themeData['lightHigh'], themeController.lightHighContrastModel);
          }
          
          if (themeData.containsKey('darkMedium') && themeData['darkMedium'] != null) {
            _applyThemeFromMap(themeData['darkMedium'], themeController.darkMediumContrastModel);
          }
          
          if (themeData.containsKey('darkHigh') && themeData['darkHigh'] != null) {
            _applyThemeFromMap(themeData['darkHigh'], themeController.darkHighContrastModel);
          }
          
          // Notifier les écouteurs du changement
          themeController.notifyListeners();
          return true;
        
        case 'dart':
          return _importFromDart(content, themeController);
        case 'xml':
          return _importFromXml(content, themeController);
        case 'css':
          return _importFromCss(content, themeController);
        default:
          return false;
      }
    } catch (e) {
      print('Error importing theme: $e');
      return false;
    }
  }
  
  // Méthode helper pour appliquer un Map à un ThemeModel
  static void _applyThemeFromMap(Map<String, dynamic> map, ThemeModel model) {
    if (map.containsKey('primary')) {
      model.primary = _hexToColor(map['primary']);
    }
    if (map.containsKey('onPrimary')) {
      model.onPrimary = _hexToColor(map['onPrimary']);
    }
    if (map.containsKey('primaryContainer')) {
      model.primaryContainer = _hexToColor(map['primaryContainer']);
    }
    if (map.containsKey('onPrimaryContainer')) {
      model.onPrimaryContainer = _hexToColor(map['onPrimaryContainer']);
    }
    if (map.containsKey('secondary')) {
      model.secondary = _hexToColor(map['secondary']);
    }
    if (map.containsKey('onSecondary')) {
      model.onSecondary = _hexToColor(map['onSecondary']);
    }
    if (map.containsKey('secondaryContainer')) {
      model.secondaryContainer = _hexToColor(map['secondaryContainer']);
    }
    if (map.containsKey('onSecondaryContainer')) {
      model.onSecondaryContainer = _hexToColor(map['onSecondaryContainer']);
    }
    if (map.containsKey('tertiary')) {
      model.tertiary = _hexToColor(map['tertiary']);
    }
    if (map.containsKey('onTertiary')) {
      model.onTertiary = _hexToColor(map['onTertiary']);
    }
    if (map.containsKey('tertiaryContainer')) {
      model.tertiaryContainer = _hexToColor(map['tertiaryContainer']);
    }
    if (map.containsKey('onTertiaryContainer')) {
      model.onTertiaryContainer = _hexToColor(map['onTertiaryContainer']);
    }
    if (map.containsKey('error')) {
      model.error = _hexToColor(map['error']);
    }
    if (map.containsKey('onError')) {
      model.onError = _hexToColor(map['onError']);
    }
    if (map.containsKey('errorContainer')) {
      model.errorContainer = _hexToColor(map['errorContainer']);
    }
    if (map.containsKey('onErrorContainer')) {
      model.onErrorContainer = _hexToColor(map['onErrorContainer']);
    }
    if (map.containsKey('background')) {
      model.background = _hexToColor(map['background']);
    }
    if (map.containsKey('onBackground')) {
      model.onBackground = _hexToColor(map['onBackground']);
    }
    if (map.containsKey('surface')) {
      model.surface = _hexToColor(map['surface']);
    }
    if (map.containsKey('onSurface')) {
      model.onSurface = _hexToColor(map['onSurface']);
    }
  }
  
  // Méthode pour convertir une chaîne hexadécimale en Color
  static Color _hexToColor(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }
    if (hex.length == 6) {
      hex = 'FF$hex'; // Ajouter l'opacité si elle n'est pas présente
    }
    return Color(int.parse(hex, radix: 16));
  }

  static Future<bool> _importFromDart(String content, ThemeController themeController) async {
    try {
      // Rechercher les définitions de ColorScheme dans le code Dart
      final RegExp schemeRegex = RegExp(r'_get(\w+)Theme\(\)\s*\{[\s\S]*?colorScheme\s*=\s*ColorScheme\.\w+\([\s\S]*?\);', multiLine: true);
      final schemeMatches = schemeRegex.allMatches(content);
      
      if (schemeMatches.isEmpty) {
        return false;
      }
      
      // Pour chaque ColorScheme trouvé
      for (final schemeMatch in schemeMatches) {
        final String? fullMatch = schemeMatch.group(0);
        if (fullMatch == null) continue;
        
        String? themeName = schemeMatch.group(1);
        if (themeName == null) continue;
        
        // Déterminer quel modèle de thème mettre à jour
        ThemeModel targetModel;
        if (themeName.contains('Light') && themeName.contains('High')) {
          targetModel = themeController.lightHighContrastModel;
        } else if (themeName.contains('Light') && themeName.contains('Medium')) {
          targetModel = themeController.lightMediumContrastModel;
        } else if (themeName.contains('Light')) {
          targetModel = themeController.currentThemeModel;
        } else if (themeName.contains('Dark') && themeName.contains('High')) {
          targetModel = themeController.darkHighContrastModel;
        } else if (themeName.contains('Dark') && themeName.contains('Medium')) {
          targetModel = themeController.darkMediumContrastModel;
        } else if (themeName.contains('Dark')) {
          targetModel = themeController.darkThemeModel;
        } else {
          continue;
        }
        
        // Extraire les couleurs individuelles
        final RegExp colorRegex = RegExp(r'(\w+):\s*Color\(0x([0-9A-Fa-f]{8})\)', multiLine: true);
        final colorMatches = colorRegex.allMatches(fullMatch);
        
        // Créer un map pour stocker les couleurs
        final Map<String, dynamic> colorMap = {};
        
        for (final colorMatch in colorMatches) {
          final String? colorName = colorMatch.group(1);
          final String? colorValue = colorMatch.group(2);
          
          if (colorName != null && colorValue != null) {
            colorMap[colorName] = '#$colorValue';
          }
        }
        
        // Appliquer les couleurs au modèle
        _applyThemeFromMap(colorMap, targetModel);
      }
      
      // Notifier les écouteurs du changement
      themeController.notifyListeners();
      return true;
    } catch (e) {
      print('Erreur lors de l\'importation Dart: $e');
      return false;
    }
  }

  static Future<bool> _importFromXml(String content, ThemeController themeController) async {
    try {
      // Rechercher les définitions de couleurs dans le XML
      final RegExp colorRegex = RegExp(r'<color\s+name="(\w+)">#([0-9A-Fa-f]{6})</color>');
      final matches = colorRegex.allMatches(content);
      
      for (final match in matches) {
        final colorName = match.group(1);
        final colorValue = match.group(2);
        
        if (colorName != null && colorValue != null) {
          final color = Color(int.parse('FF$colorValue', radix: 16));
          themeController.updateThemeColor(colorName, color);
        }
      }
      
      return true;
    } catch (e) {
      print('Erreur lors de l\'importation XML: $e');
      return false;
    }
  }

  static Future<bool> _importFromCss(String content, ThemeController themeController) async {
    try {
      // Rechercher les définitions de couleurs dans le CSS
      final RegExp colorRegex = RegExp(r'--(\w+(?:-\w+)*):\s*#([0-9A-Fa-f]{6});');
      final matches = colorRegex.allMatches(content);
      
      for (final match in matches) {
        String? colorName = match.group(1);
        final colorValue = match.group(2);
        
        if (colorName != null && colorValue != null) {
          // Convertir les noms CSS (kebab-case) en camelCase
          colorName = colorName.replaceAllMapped(
            RegExp(r'-(\w)'),
            (match) => match.group(1)!.toUpperCase(),
          );
          
          final color = Color(int.parse('FF$colorValue', radix: 16));
          themeController.updateThemeColor(colorName, color);
        }
      }
      
      return true;
    } catch (e) {
      print('Erreur lors de l\'importation CSS: $e');
      return false;
    }
  }
}