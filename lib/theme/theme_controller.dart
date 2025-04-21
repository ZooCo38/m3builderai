import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import '../models/theme_model.dart';
import 'material_theme.dart';

import 'package:flutter/material.dart';
import '../models/theme_model.dart';

// Enum pour les niveaux de contraste
enum ContrastLevel {
  normal,
  medium,
  high,
}

// Classe pour stocker les informations sur le composant sélectionné
class ComponentInfo {
  final String componentName;
  final List<String> usedColorProperties;
  
  ComponentInfo(this.componentName, this.usedColorProperties);
}

class ThemeController extends ChangeNotifier {
  // Modèles de thème pour différents modes et niveaux de contraste
  final ThemeModel _currentThemeModel = ThemeModel();
  final ThemeModel _darkThemeModel = ThemeModel();
  final ThemeModel _lightMediumContrastModel = ThemeModel();
  final ThemeModel _lightHighContrastModel = ThemeModel();
  final ThemeModel _darkMediumContrastModel = ThemeModel();
  final ThemeModel _darkHighContrastModel = ThemeModel();
  
  // Getters pour exposer les modèles
  ThemeModel get currentThemeModel => _currentThemeModel;
  ThemeModel get darkThemeModel => _darkThemeModel;
  ThemeModel get lightMediumContrastModel => _lightMediumContrastModel;
  ThemeModel get lightHighContrastModel => _lightHighContrastModel;
  ThemeModel get darkMediumContrastModel => _darkMediumContrastModel;
  ThemeModel get darkHighContrastModel => _darkHighContrastModel;
  
  // Mode de thème actuel
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  
  // Niveau de contraste actuel
  ContrastLevel _contrastLevel = ContrastLevel.normal;
  ContrastLevel get contrastLevel => _contrastLevel;
  
  // Informations sur le composant sélectionné
  ComponentInfo? _selectedComponentInfo;
  ComponentInfo? get selectedComponentInfo => _selectedComponentInfo;
  
  // Propriétés pour FlexColorScheme
  bool _useFlexColorScheme = false;
  bool get useFlexColorScheme => _useFlexColorScheme;
  
  FlexScheme _flexScheme = FlexScheme.material;
  FlexScheme get flexScheme => _flexScheme;
  
  double _blendLevel = 20;
  double get blendLevel => _blendLevel;
  
  bool _useMaterial3 = true;
  bool get useMaterial3 => _useMaterial3;
  
  // Constructeur
  ThemeController() {
    _initializeThemes();
  }
  
  // Initialiser les thèmes
  void _initializeThemes() {
    // Utiliser le schéma de couleur Material 3 Purple au lieu du schéma générique
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4), // Couleur primaire du thème Purple
      brightness: Brightness.light,
    );
    
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4), // Couleur primaire du thème Purple
      brightness: Brightness.dark,
    );
    
    // Initialiser le thème clair normal
    _initializeThemeModel(_currentThemeModel, lightColorScheme);
    
    // Initialiser le thème sombre normal
    _initializeThemeModel(_darkThemeModel, darkColorScheme);
    
    // Initialiser les thèmes à contraste moyen
    _initializeThemeModel(_lightMediumContrastModel, lightColorScheme);
    _initializeThemeModel(_darkMediumContrastModel, darkColorScheme);
    
    // Initialiser les thèmes à contraste élevé
    _initializeThemeModel(_lightHighContrastModel, lightColorScheme);
    _initializeThemeModel(_darkHighContrastModel, darkColorScheme);
  }
  
  // Initialiser un modèle de thème à partir d'un ColorScheme
  void _initializeThemeModel(ThemeModel model, ColorScheme scheme) {
    model.primary = scheme.primary;
    model.onPrimary = scheme.onPrimary;
    model.primaryContainer = scheme.primaryContainer;
    model.onPrimaryContainer = scheme.onPrimaryContainer;
    
    model.secondary = scheme.secondary;
    model.onSecondary = scheme.onSecondary;
    model.secondaryContainer = scheme.secondaryContainer;
    model.onSecondaryContainer = scheme.onSecondaryContainer;
    
    model.tertiary = scheme.tertiary;
    model.onTertiary = scheme.onTertiary;
    model.tertiaryContainer = scheme.tertiaryContainer;
    model.onTertiaryContainer = scheme.onTertiaryContainer;
    
    model.error = scheme.error;
    model.onError = scheme.onError;
    model.errorContainer = scheme.errorContainer;
    model.onErrorContainer = scheme.onErrorContainer;
    
    model.background = scheme.background;
    model.onBackground = scheme.onBackground;
    
    model.surface = scheme.surface;
    model.onSurface = scheme.onSurface;
    model.surfaceVariant = scheme.surfaceVariant;
    model.onSurfaceVariant = scheme.onSurfaceVariant;
    
    model.outline = scheme.outline;
    model.outlineVariant = scheme.outlineVariant;
    
    // Nouvelles propriétés pour Material 3
    model.surfaceContainer = scheme.surface.withOpacity(0.9);
    model.surfaceContainerLow = scheme.surface.withOpacity(0.95);
    model.surfaceContainerHigh = scheme.surface.withOpacity(0.85);
    model.surfaceContainerHighest = scheme.surface.withOpacity(0.8);
    model.surfaceBright = scheme.brightness == Brightness.light ? Colors.white : Colors.grey.shade900;
    model.surfaceDim = scheme.brightness == Brightness.light ? Colors.grey.shade50 : Colors.grey.shade800;
    model.elevation = scheme.brightness == Brightness.light ? Colors.black12 : Colors.white12;
  }
  
  // Obtenir le thème actuel
  ThemeData get currentTheme {
    final brightness = _themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light;
    final model = _getModelForCurrentSettings();
    
    if (_useFlexColorScheme) {
      return _createFlexTheme(brightness);
    } else {
      return ThemeData(
        useMaterial3: _useMaterial3,
        colorScheme: model.toColorScheme(brightness),
        brightness: brightness,
      );
    }
  }
  
  // Créer un thème avec FlexColorScheme
  ThemeData _createFlexTheme(Brightness brightness) {
    if (brightness == Brightness.light) {
      return FlexThemeData.light(
        scheme: _flexScheme,
        blendLevel: _blendLevel.toInt(),
        useMaterial3: _useMaterial3,
      );
    } else {
      return FlexThemeData.dark(
        scheme: _flexScheme,
        blendLevel: _blendLevel.toInt(),
        useMaterial3: _useMaterial3,
      );
    }
  }
  
  // Getters pour les thèmes light et dark (pour MaterialApp)
  ThemeData get lightTheme => _useFlexColorScheme 
      ? _createFlexTheme(Brightness.light) 
      : ThemeData(
          useMaterial3: _useMaterial3,
          colorScheme: _currentThemeModel.toColorScheme(Brightness.light),
          brightness: Brightness.light,
        );
  
  ThemeData get darkTheme => _useFlexColorScheme 
      ? _createFlexTheme(Brightness.dark) 
      : ThemeData(
          useMaterial3: _useMaterial3,
          colorScheme: _darkThemeModel.toColorScheme(Brightness.dark),
          brightness: Brightness.dark,
        );
  
  // Obtenir le modèle de thème en fonction des paramètres actuels
  ThemeModel _getModelForCurrentSettings() {
    if (_themeMode == ThemeMode.dark) {
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          return _darkThemeModel;
        case ContrastLevel.medium:
          return _darkMediumContrastModel;
        case ContrastLevel.high:
          return _darkHighContrastModel;
      }
    } else {
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          return _currentThemeModel;
        case ContrastLevel.medium:
          return _lightMediumContrastModel;
        case ContrastLevel.high:
          return _lightHighContrastModel;
      }
    }
  }
  
  // Définir le mode de thème
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  
  // Définir le niveau de contraste
  void setContrastLevel(ContrastLevel level) {
    _contrastLevel = level;
    notifyListeners();
  }
  
  // Définir le composant sélectionné
  void setSelectedComponent(String componentName, List<String> colorProperties) {
    _selectedComponentInfo = ComponentInfo(componentName, colorProperties);
    notifyListeners();
  }
  
  // Méthodes pour FlexColorScheme
  void setUseFlexColorScheme(bool value) {
    _useFlexColorScheme = value;
    notifyListeners();
  }
  
  void setFlexScheme(FlexScheme scheme) {
    _flexScheme = scheme;
    notifyListeners();
  }
  
  void setBlendLevel(double value) {
    _blendLevel = value;
    notifyListeners();
  }
  
  void setUseMaterial3(bool value) {
    _useMaterial3 = value;
    notifyListeners();
  }
  
  // Mettre à jour une couleur du thème
  void updateThemeColor(String colorName, Color color) {
    // Déterminer quel modèle mettre à jour en fonction du mode actuel ET du niveau de contraste
    ThemeModel modelToUpdate;
    
    // Sélectionner le modèle approprié en fonction du mode et du niveau de contraste
    if (_themeMode == ThemeMode.dark) {
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          modelToUpdate = _darkThemeModel;
          break;
        case ContrastLevel.medium:
          modelToUpdate = _darkMediumContrastModel;
          break;
        case ContrastLevel.high:
          modelToUpdate = _darkHighContrastModel;
          break;
      }
    } else {
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          modelToUpdate = _currentThemeModel;
          break;
        case ContrastLevel.medium:
          modelToUpdate = _lightMediumContrastModel;
          break;
        case ContrastLevel.high:
          modelToUpdate = _lightHighContrastModel;
          break;
      }
    }
    
    // Mettre à jour la couleur dans le modèle approprié
    switch (colorName) {
      case 'primary':
        modelToUpdate.primary = color;
        break;
      case 'onPrimary':
        modelToUpdate.onPrimary = color;
        break;
      case 'primaryContainer':
        modelToUpdate.primaryContainer = color;
        break;
      case 'onPrimaryContainer':
        modelToUpdate.onPrimaryContainer = color;
        break;
      case 'secondary':
        modelToUpdate.secondary = color;
        break;
      case 'onSecondary':
        modelToUpdate.onSecondary = color;
        break;
      case 'secondaryContainer':
        modelToUpdate.secondaryContainer = color;
        break;
      case 'onSecondaryContainer':
        modelToUpdate.onSecondaryContainer = color;
        break;
      case 'tertiary':
        modelToUpdate.tertiary = color;
        break;
      case 'onTertiary':
        modelToUpdate.onTertiary = color;
        break;
      case 'tertiaryContainer':
        modelToUpdate.tertiaryContainer = color;
        break;
      case 'onTertiaryContainer':
        modelToUpdate.onTertiaryContainer = color;
        break;
      case 'error':
        modelToUpdate.error = color;
        break;
      case 'onError':
        modelToUpdate.onError = color;
        break;
      case 'errorContainer':
        modelToUpdate.errorContainer = color;
        break;
      case 'onErrorContainer':
        modelToUpdate.onErrorContainer = color;
        break;
      case 'background':
        modelToUpdate.background = color;
        break;
      case 'onBackground':
        modelToUpdate.onBackground = color;
        break;
      case 'surface':
        modelToUpdate.surface = color;
        break;
      case 'onSurface':
        modelToUpdate.onSurface = color;
        break;
      case 'surfaceVariant':
        modelToUpdate.surfaceVariant = color;
        break;
      case 'onSurfaceVariant':
        modelToUpdate.onSurfaceVariant = color;
        break;
      case 'outline':
        modelToUpdate.outline = color;
        break;
      case 'outlineVariant':
        modelToUpdate.outlineVariant = color;
        break;
      // Nouveaux cas
      case 'surfaceContainer':
        modelToUpdate.surfaceContainer = color;
        break;
      case 'surfaceContainerLow':
        modelToUpdate.surfaceContainerLow = color;
        break;
      case 'surfaceContainerHigh':
        modelToUpdate.surfaceContainerHigh = color;
        break;
      case 'surfaceContainerHighest':
        modelToUpdate.surfaceContainerHighest = color;
        break;
      case 'surfaceBright':
        modelToUpdate.surfaceBright = color;
        break;
      case 'surfaceDim':
        modelToUpdate.surfaceDim = color;
        break;
      case 'elevation':
        modelToUpdate.elevation = color;
        break;
    }
    
    // Notifier les écouteurs du changement
    notifyListeners();
  }
  
  // Obtenir la couleur actuelle en fonction du mode et du niveau de contraste
  Color getCurrentColor(String colorName) {
    bool isDark = _themeMode == ThemeMode.dark;
    ThemeModel modelToUse;
    
    // Sélectionner le modèle approprié en fonction du mode et du niveau de contraste
    if (isDark) {
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          modelToUse = _darkThemeModel;
          break;
        case ContrastLevel.medium:
          modelToUse = _darkMediumContrastModel;
          break;
        case ContrastLevel.high:
          modelToUse = _darkHighContrastModel;
          break;
      }
    } else {
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          modelToUse = _currentThemeModel;
          break;
        case ContrastLevel.medium:
          modelToUse = _lightMediumContrastModel;
          break;
        case ContrastLevel.high:
          modelToUse = _lightHighContrastModel;
          break;
      }
    }
    
    // Retourner la couleur appropriée du modèle sélectionné
    switch (colorName) {
      case 'primary': return modelToUse.primary;
      case 'onPrimary': return modelToUse.onPrimary;
      case 'primaryContainer': return modelToUse.primaryContainer;
      case 'onPrimaryContainer': return modelToUse.onPrimaryContainer;
      case 'secondary': return modelToUse.secondary;
      case 'onSecondary': return modelToUse.onSecondary;
      case 'secondaryContainer': return modelToUse.secondaryContainer;
      case 'onSecondaryContainer': return modelToUse.onSecondaryContainer;
      case 'tertiary': return modelToUse.tertiary;
      case 'onTertiary': return modelToUse.onTertiary;
      case 'tertiaryContainer': return modelToUse.tertiaryContainer;
      case 'onTertiaryContainer': return modelToUse.onTertiaryContainer;
      case 'error': return modelToUse.error;
      case 'onError': return modelToUse.onError;
      case 'errorContainer': return modelToUse.errorContainer;
      case 'onErrorContainer': return modelToUse.onErrorContainer;
      case 'background': return modelToUse.background;
      case 'onBackground': return modelToUse.onBackground;
      case 'surface': return modelToUse.surface;
      case 'onSurface': return modelToUse.onSurface;
      case 'surfaceVariant': return modelToUse.surfaceVariant;
      case 'onSurfaceVariant': return modelToUse.onSurfaceVariant;
      case 'outline': return modelToUse.outline;
      case 'outlineVariant': return modelToUse.outlineVariant;
      // Nouveaux cas
      case 'surfaceContainer': return modelToUse.surfaceContainer;
      case 'surfaceContainerLow': return modelToUse.surfaceContainerLow;
      case 'surfaceContainerHigh': return modelToUse.surfaceContainerHigh;
      case 'surfaceContainerHighest': return modelToUse.surfaceContainerHighest;
      case 'surfaceBright': return modelToUse.surfaceBright;
      case 'surfaceDim': return modelToUse.surfaceDim;
      case 'elevation': return modelToUse.elevation;
      
      default: return isDark ? Colors.black : Colors.white;
    }
  }
}