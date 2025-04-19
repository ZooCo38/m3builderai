import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/theme_model.dart';
import '../utils/platform_helper.dart';

// Supprimer cette ligne car elle est déjà importée ci-dessus
// import 'dart:html' as html;

class ThemeExporter {
  static Future<String?> exportTheme(
    ThemeModel themeModel,
    String format,
    Brightness brightness, {
    ThemeModel? darkThemeModel,
    ThemeModel? lightMediumModel,
    ThemeModel? lightHighModel,
    ThemeModel? darkMediumModel,
    ThemeModel? darkHighModel,
  }) async {
    // Créer un Map contenant tous les modèles de thème
    final Map<String, dynamic> themeData = {
      'lightStandard': _themeModelToMap(themeModel),
      'darkStandard': darkThemeModel != null ? _themeModelToMap(darkThemeModel) : null,
      'lightMedium': lightMediumModel != null ? _themeModelToMap(lightMediumModel) : null,
      'lightHigh': lightHighModel != null ? _themeModelToMap(lightHighModel) : null,
      'darkMedium': darkMediumModel != null ? _themeModelToMap(darkMediumModel) : null,
      'darkHigh': darkHighModel != null ? _themeModelToMap(darkHighModel) : null,
    };
    
    // Convertir en format demandé
    switch (format) {
      case 'json':
        return jsonEncode(themeData);
      case 'dart':
        return _exportToDart(
          themeModel, 
          brightness,
          darkTheme: darkThemeModel,
          lightMediumModel: lightMediumModel,
          lightHighModel: lightHighModel,
          darkMediumModel: darkMediumModel,
          darkHighModel: darkHighModel,
        );
      case 'xml':
        return _exportToXml(themeModel);
      case 'css':
        return _exportToCss(themeModel);
      default:
        return null;
    }
  }

  // Méthode helper pour convertir un ThemeModel en Map
  static Map<String, String> _themeModelToMap(ThemeModel model) {
    return {
      'primary': _colorToHex(model.primary),
      'onPrimary': _colorToHex(model.onPrimary),
      'primaryContainer': _colorToHex(model.primaryContainer),
      'onPrimaryContainer': _colorToHex(model.onPrimaryContainer),
      'secondary': _colorToHex(model.secondary),
      'onSecondary': _colorToHex(model.onSecondary),
      'secondaryContainer': _colorToHex(model.secondaryContainer),
      'onSecondaryContainer': _colorToHex(model.onSecondaryContainer),
      'tertiary': _colorToHex(model.tertiary),
      'onTertiary': _colorToHex(model.onTertiary),
      'tertiaryContainer': _colorToHex(model.tertiaryContainer),
      'onTertiaryContainer': _colorToHex(model.onTertiaryContainer),
      'error': _colorToHex(model.error),
      'onError': _colorToHex(model.onError),
      'errorContainer': _colorToHex(model.errorContainer),
      'onErrorContainer': _colorToHex(model.onErrorContainer),
      'background': _colorToHex(model.background),
      'onBackground': _colorToHex(model.onBackground),
      'surface': _colorToHex(model.surface),
      'onSurface': _colorToHex(model.onSurface),
    };
  }
  
  // Méthode pour convertir une Color en chaîne hexadécimale
  static String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  }

  static Future<void> saveExportedTheme(String content, String format) async {
    final fileName = 'theme.$format';
    
    if (PlatformHelper.isWeb) {
      // Méthode pour le web
      final bytes = utf8.encode(content);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..style.display = 'none';
      
      html.document.body?.children.add(anchor);
      anchor.click();
      
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    } else {
      // Pour les plateformes natives, nous utiliserions dart:io
      // Mais comme nous sommes sur le web, cette partie n'est pas nécessaire
      print('Saving to native platforms is not implemented in this web version');
    }
  }

  static String _exportToDart(ThemeModel theme, Brightness brightness, {
    ThemeModel? darkTheme,
    ThemeModel? lightMediumModel,
    ThemeModel? lightHighModel,
    ThemeModel? darkMediumModel,
    ThemeModel? darkHighModel,
  }) {
    final buffer = StringBuffer();
    
    buffer.writeln('import \'package:flutter/material.dart\';');
    buffer.writeln();
    
    // Fonction principale pour obtenir le thème
    buffer.writeln('ThemeData getTheme({ThemeMode themeMode = ThemeMode.light, ContrastLevel contrastLevel = ContrastLevel.normal}) {');
    buffer.writeln('  switch (themeMode) {');
    buffer.writeln('    case ThemeMode.light:');
    buffer.writeln('      switch (contrastLevel) {');
    buffer.writeln('        case ContrastLevel.normal:');
    buffer.writeln('          return _getLightTheme();');
    buffer.writeln('        case ContrastLevel.medium:');
    buffer.writeln('          return _getLightMediumContrastTheme();');
    buffer.writeln('        case ContrastLevel.high:');
    buffer.writeln('          return _getLightHighContrastTheme();');
    buffer.writeln('      }');
    buffer.writeln('    case ThemeMode.dark:');
    buffer.writeln('      switch (contrastLevel) {');
    buffer.writeln('        case ContrastLevel.normal:');
    buffer.writeln('          return _getDarkTheme();');
    buffer.writeln('        case ContrastLevel.medium:');
    buffer.writeln('          return _getDarkMediumContrastTheme();');
    buffer.writeln('        case ContrastLevel.high:');
    buffer.writeln('          return _getDarkHighContrastTheme();');
    buffer.writeln('      }');
    buffer.writeln('    default:');
    buffer.writeln('      return _getLightTheme();');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();
    
    // Définir l'enum ContrastLevel
    buffer.writeln('enum ContrastLevel { normal, medium, high }');
    buffer.writeln();
    
    // Thème Light Normal
    buffer.writeln('ThemeData _getLightTheme() {');
    buffer.writeln('  final colorScheme = ColorScheme.light(');
    _writeColorSchemeProperties(buffer, theme);
    buffer.writeln('  );');
    buffer.writeln();
    buffer.writeln('  return ThemeData(');
    buffer.writeln('    colorScheme: colorScheme,');
    buffer.writeln('    useMaterial3: true,');
    buffer.writeln('  );');
    buffer.writeln('}');
    buffer.writeln();
    
    // Thème Light Medium Contrast
    if (lightMediumModel != null) {
      buffer.writeln('ThemeData _getLightMediumContrastTheme() {');
      buffer.writeln('  final colorScheme = ColorScheme.light(');
      _writeColorSchemeProperties(buffer, lightMediumModel);
      buffer.writeln('  );');
      buffer.writeln();
      buffer.writeln('  return ThemeData(');
      buffer.writeln('    colorScheme: colorScheme,');
      buffer.writeln('    useMaterial3: true,');
      buffer.writeln('  );');
      buffer.writeln('}');
      buffer.writeln();
    }
    
    // Thème Light High Contrast
    if (lightHighModel != null) {
      buffer.writeln('ThemeData _getLightHighContrastTheme() {');
      buffer.writeln('  final colorScheme = ColorScheme.light(');
      _writeColorSchemeProperties(buffer, lightHighModel);
      buffer.writeln('  );');
      buffer.writeln();
      buffer.writeln('  return ThemeData(');
      buffer.writeln('    colorScheme: colorScheme,');
      buffer.writeln('    useMaterial3: true,');
      buffer.writeln('  );');
      buffer.writeln('}');
      buffer.writeln();
    }
    
    // Thème Dark Normal
    if (darkTheme != null) {
      buffer.writeln('ThemeData _getDarkTheme() {');
      buffer.writeln('  final colorScheme = ColorScheme.dark(');
      _writeColorSchemeProperties(buffer, darkTheme);
      buffer.writeln('  );');
      buffer.writeln();
      buffer.writeln('  return ThemeData(');
      buffer.writeln('    colorScheme: colorScheme,');
      buffer.writeln('    useMaterial3: true,');
      buffer.writeln('  );');
      buffer.writeln('}');
      buffer.writeln();
    }
    
    // Thème Dark Medium Contrast
    if (darkMediumModel != null) {
      buffer.writeln('ThemeData _getDarkMediumContrastTheme() {');
      buffer.writeln('  final colorScheme = ColorScheme.dark(');
      _writeColorSchemeProperties(buffer, darkMediumModel);
      buffer.writeln('  );');
      buffer.writeln();
      buffer.writeln('  return ThemeData(');
      buffer.writeln('    colorScheme: colorScheme,');
      buffer.writeln('    useMaterial3: true,');
      buffer.writeln('  );');
      buffer.writeln('}');
      buffer.writeln();
    }
    
    // Thème Dark High Contrast
    if (darkHighModel != null) {
      buffer.writeln('ThemeData _getDarkHighContrastTheme() {');
      buffer.writeln('  final colorScheme = ColorScheme.dark(');
      _writeColorSchemeProperties(buffer, darkHighModel);
      buffer.writeln('  );');
      buffer.writeln();
      buffer.writeln('  return ThemeData(');
      buffer.writeln('    colorScheme: colorScheme,');
      buffer.writeln('    useMaterial3: true,');
      buffer.writeln('  );');
      buffer.writeln('}');
    }
    
    return buffer.toString();
  }

  static String _exportToXml(ThemeModel theme) {
    final buffer = StringBuffer();
    
    buffer.writeln('<?xml version="1.0" encoding="utf-8"?>');
    buffer.writeln('<resources>');
    buffer.writeln('  <color name="primary">#${theme.primary.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onPrimary">#${theme.onPrimary.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="primaryContainer">#${theme.primaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onPrimaryContainer">#${theme.onPrimaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="secondary">#${theme.secondary.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onSecondary">#${theme.onSecondary.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="secondaryContainer">#${theme.secondaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onSecondaryContainer">#${theme.onSecondaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="tertiary">#${theme.tertiary.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onTertiary">#${theme.onTertiary.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="tertiaryContainer">#${theme.tertiaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onTertiaryContainer">#${theme.onTertiaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="error">#${theme.error.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onError">#${theme.onError.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="errorContainer">#${theme.errorContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onErrorContainer">#${theme.onErrorContainer.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="background">#${theme.background.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onBackground">#${theme.onBackground.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="surface">#${theme.surface.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('  <color name="onSurface">#${theme.onSurface.value.toRadixString(16).substring(2, 8).toUpperCase()}</color>');
    buffer.writeln('</resources>');
    
    return buffer.toString();
  }

  static String _exportToCss(ThemeModel theme) {
    final buffer = StringBuffer();
    
    buffer.writeln(':root {');
    buffer.writeln('  --primary: #${theme.primary.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-primary: #${theme.onPrimary.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --primary-container: #${theme.primaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-primary-container: #${theme.onPrimaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --secondary: #${theme.secondary.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-secondary: #${theme.onSecondary.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --secondary-container: #${theme.secondaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-secondary-container: #${theme.onSecondaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --tertiary: #${theme.tertiary.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-tertiary: #${theme.onTertiary.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --tertiary-container: #${theme.tertiaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-tertiary-container: #${theme.onTertiaryContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --error: #${theme.error.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-error: #${theme.onError.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --error-container: #${theme.errorContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-error-container: #${theme.onErrorContainer.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --background: #${theme.background.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-background: #${theme.onBackground.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --surface: #${theme.surface.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('  --on-surface: #${theme.onSurface.value.toRadixString(16).substring(2, 8).toUpperCase()};');
    buffer.writeln('}');
    
    return buffer.toString();
  }

  // Ajouter ces méthodes à la classe ThemeExporter
  
  // Méthode pour déterminer si une couleur est sombre
  static bool _isColorDark(Color color) {
    return color.computeLuminance() < 0.5;
  }
  
  // Méthodes pour dériver les couleurs selon les règles Material 3
  static Color _deriveSurfaceVariant(ThemeModel model, bool isDark) {
    if (isDark) {
      return Color.lerp(model.surface, model.onSurface, 0.08)!;
    } else {
      return Color.lerp(model.surface, model.onSurface, 0.05)!;
    }
  }
  
  static Color _deriveOnSurfaceVariant(ThemeModel model, bool isDark) {
    if (isDark) {
      return Color.lerp(model.onSurface, model.surface, 0.15)!;
    } else {
      return Color.lerp(model.onSurface, model.surface, 0.25)!;
    }
  }
  
  static Color _deriveOutline(ThemeModel model, bool isDark) {
    if (isDark) {
      return Color.lerp(model.onSurface, model.surface, 0.35)!;
    } else {
      return Color.lerp(model.onSurface, model.surface, 0.45)!;
    }
  }
  
  static Color _deriveOutlineVariant(ThemeModel model, bool isDark) {
    if (isDark) {
      return Color.lerp(model.onSurface, model.surface, 0.5)!;
    } else {
      return Color.lerp(model.onSurface, model.surface, 0.7)!;
    }
  }
  
  static Color _deriveInverseSurface(ThemeModel model, bool isDark) {
    if (isDark) {
      return Color.lerp(model.onSurface, model.surface, 0.9)!;
    } else {
      return Color.lerp(model.onSurface, model.surface, 0.1)!;
    }
  }
  
  static Color _deriveInverseOnSurface(ThemeModel model, bool isDark) {
    if (isDark) {
      return Color.lerp(model.surface, model.onSurface, 0.9)!;
    } else {
      return Color.lerp(model.surface, model.onSurface, 0.1)!;
    }
  }
  
  static Color _deriveInversePrimary(ThemeModel model, bool isDark) {
    if (isDark) {
      return Color.lerp(model.primary, Colors.white, 0.4)!;
    } else {
      return Color.lerp(model.primary, Colors.black, 0.3)!;
    }
  }
  
  // Ajouter cette méthode à la classe ThemeExporter
  static void _writeColorSchemeProperties(StringBuffer buffer, ThemeModel theme) {
    // Couleurs de base
    buffer.writeln('    primary: Color(0x${theme.primary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onPrimary: Color(0x${theme.onPrimary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    primaryContainer: Color(0x${theme.primaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onPrimaryContainer: Color(0x${theme.onPrimaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    secondary: Color(0x${theme.secondary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onSecondary: Color(0x${theme.onSecondary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    secondaryContainer: Color(0x${theme.secondaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onSecondaryContainer: Color(0x${theme.onSecondaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    tertiary: Color(0x${theme.tertiary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onTertiary: Color(0x${theme.onTertiary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    tertiaryContainer: Color(0x${theme.tertiaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onTertiaryContainer: Color(0x${theme.onTertiaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    error: Color(0x${theme.error.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onError: Color(0x${theme.onError.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    errorContainer: Color(0x${theme.errorContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onErrorContainer: Color(0x${theme.onErrorContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    background: Color(0x${theme.background.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onBackground: Color(0x${theme.onBackground.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    surface: Color(0x${theme.surface.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onSurface: Color(0x${theme.onSurface.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    // Couleurs dérivées
    final bool isDark = _isColorDark(theme.background);
    
    buffer.writeln('    surfaceTint: Color(0x${theme.primary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color surfaceVariant = _deriveSurfaceVariant(theme, isDark);
    buffer.writeln('    surfaceVariant: Color(0x${surfaceVariant.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color onSurfaceVariant = _deriveOnSurfaceVariant(theme, isDark);
    buffer.writeln('    onSurfaceVariant: Color(0x${onSurfaceVariant.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color outline = _deriveOutline(theme, isDark);
    buffer.writeln('    outline: Color(0x${outline.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color outlineVariant = _deriveOutlineVariant(theme, isDark);
    buffer.writeln('    outlineVariant: Color(0x${outlineVariant.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    buffer.writeln('    shadow: Color(0xFF000000),');
    buffer.writeln('    scrim: Color(0xFF000000),');
    
    Color inverseSurface = _deriveInverseSurface(theme, isDark);
    buffer.writeln('    inverseSurface: Color(0x${inverseSurface.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color inverseOnSurface = _deriveInverseOnSurface(theme, isDark);
    buffer.writeln('    inverseOnSurface: Color(0x${inverseOnSurface.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color inversePrimary = _deriveInversePrimary(theme, isDark);
    buffer.writeln('    inversePrimary: Color(0x${inversePrimary.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    // Ajout des couleurs Fixed
    buffer.writeln('    primaryFixed: Color(0x${theme.primaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onPrimaryFixed: Color(0x${theme.onPrimaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color primaryFixedDim = Color.lerp(theme.primaryContainer, theme.primary, 0.3)!;
    buffer.writeln('    primaryFixedDim: Color(0x${primaryFixedDim.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color onPrimaryFixedVariant = Color.lerp(theme.onPrimaryContainer, theme.primary, 0.3)!;
    buffer.writeln('    onPrimaryFixedVariant: Color(0x${onPrimaryFixedVariant.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    buffer.writeln('    secondaryFixed: Color(0x${theme.secondaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onSecondaryFixed: Color(0x${theme.onSecondaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color secondaryFixedDim = Color.lerp(theme.secondaryContainer, theme.secondary, 0.3)!;
    buffer.writeln('    secondaryFixedDim: Color(0x${secondaryFixedDim.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color onSecondaryFixedVariant = Color.lerp(theme.onSecondaryContainer, theme.secondary, 0.3)!;
    buffer.writeln('    onSecondaryFixedVariant: Color(0x${onSecondaryFixedVariant.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    buffer.writeln('    tertiaryFixed: Color(0x${theme.tertiaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    buffer.writeln('    onTertiaryFixed: Color(0x${theme.onTertiaryContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color tertiaryFixedDim = Color.lerp(theme.tertiaryContainer, theme.tertiary, 0.3)!;
    buffer.writeln('    tertiaryFixedDim: Color(0x${tertiaryFixedDim.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color onTertiaryFixedVariant = Color.lerp(theme.onTertiaryContainer, theme.tertiary, 0.3)!;
    buffer.writeln('    onTertiaryFixedVariant: Color(0x${onTertiaryFixedVariant.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    // Ajout des couleurs Surface Container
    Color surfaceDim = isDark 
        ? theme.surface 
        : Color.lerp(theme.surface, theme.onSurface, 0.03)!;
    buffer.writeln('    surfaceDim: Color(0x${surfaceDim.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color surfaceBright = isDark 
        ? Color.lerp(theme.surface, theme.onSurface, 0.1)! 
        : theme.surface;
    buffer.writeln('    surfaceBright: Color(0x${surfaceBright.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color surfaceContainerLowest = isDark 
        ? Color.lerp(theme.surface, Colors.black, 0.1)! 
        : Colors.white;
    buffer.writeln('    surfaceContainerLowest: Color(0x${surfaceContainerLowest.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color surfaceContainerLow = Color.lerp(theme.surface, theme.onSurface, 0.02)!;
    buffer.writeln('    surfaceContainerLow: Color(0x${surfaceContainerLow.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color surfaceContainer = isDark 
        ? Color.lerp(theme.surface, theme.onSurface, 0.04)! 
        : Color.lerp(theme.surface, theme.onSurface, 0.03)!;
    buffer.writeln('    surfaceContainer: Color(0x${surfaceContainer.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color surfaceContainerHigh = isDark 
        ? Color.lerp(theme.surface, theme.onSurface, 0.06)! 
        : Color.lerp(theme.surface, theme.onSurface, 0.05)!;
    buffer.writeln('    surfaceContainerHigh: Color(0x${surfaceContainerHigh.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
    
    Color surfaceContainerHighest = isDark 
        ? Color.lerp(theme.surface, theme.onSurface, 0.08)! 
        : Color.lerp(theme.surface, theme.onSurface, 0.06)!;
    buffer.writeln('    surfaceContainerHighest: Color(0x${surfaceContainerHighest.value.toRadixString(16).padLeft(8, '0').toUpperCase()}),');
  } }
