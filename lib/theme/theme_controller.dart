import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import '../models/theme_model.dart';
import 'material_theme.dart';

enum ContrastLevel {
  normal,
  medium,
  high,
}

class ThemeController extends ChangeNotifier {
  // Modèles de thème existants
  final ThemeModel _currentThemeModel = ThemeModel();
  final ThemeModel _darkThemeModel = ThemeModel();
  
  // Nouveaux modèles pour les différents niveaux de contraste
  late ThemeModel _lightMediumContrastModel;
  late ThemeModel _lightHighContrastModel;
  late ThemeModel _darkMediumContrastModel;
  late ThemeModel _darkHighContrastModel;
  ThemeMode _themeMode = ThemeMode.light;
  ContrastLevel _contrastLevel = ContrastLevel.normal;
  
  // Nouvelles propriétés pour flex_color_scheme
  FlexScheme _flexScheme = FlexScheme.material;
  bool _useFlexColorScheme = false;
  double _blendLevel = 0;
  bool _useMaterial3 = true;
  
  // Instance de MaterialTheme pour accéder aux thèmes prédéfinis
  final MaterialTheme _materialTheme = const MaterialTheme();
  
  // Constructeur
  ThemeController() {
    // Ne pas réassigner les variables finales
    // _currentThemeModel = ThemeModel(); // Supprimer cette ligne
    // _darkThemeModel = ThemeModel();    // Supprimer cette ligne
    _initializeFromMaterialTheme();
  }

  // Initialiser le modèle de thème à partir de MaterialTheme
  void _initializeFromMaterialTheme() {
    // Initialiser le modèle light normal
    final lightScheme = MaterialTheme.lightScheme().toColorScheme();
    _initializeThemeModel(_currentThemeModel, lightScheme);
    
    // Initialiser le modèle light medium contrast
    final lightMediumScheme = MaterialTheme.lightMediumContrastScheme().toColorScheme();
    _lightMediumContrastModel = ThemeModel();
    _initializeThemeModel(_lightMediumContrastModel, lightMediumScheme);
    
    // Initialiser le modèle light high contrast
    final lightHighScheme = MaterialTheme.lightHighContrastScheme().toColorScheme();
    _lightHighContrastModel = ThemeModel();
    _initializeThemeModel(_lightHighContrastModel, lightHighScheme);
    
    // Initialiser le modèle dark normal
    final darkScheme = MaterialTheme.darkScheme().toColorScheme();
    _initializeThemeModel(_darkThemeModel, darkScheme);
    
    // Initialiser le modèle dark medium contrast
    final darkMediumScheme = MaterialTheme.darkMediumContrastScheme().toColorScheme();
    _darkMediumContrastModel = ThemeModel();
    _initializeThemeModel(_darkMediumContrastModel, darkMediumScheme);
    
    // Initialiser le modèle dark high contrast
    final darkHighScheme = MaterialTheme.darkHighContrastScheme().toColorScheme();
    _darkHighContrastModel = ThemeModel();
    _initializeThemeModel(_darkHighContrastModel, darkHighScheme);
  }

  // Méthode d'aide pour initialiser un modèle de thème à partir d'un schéma de couleurs
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
  }
  
  // Getters
  ThemeModel get currentThemeModel => _currentThemeModel;
  ThemeModel get darkThemeModel => _darkThemeModel;
  ThemeModel get lightMediumContrastModel => _lightMediumContrastModel;
  ThemeModel get lightHighContrastModel => _lightHighContrastModel;
  ThemeModel get darkMediumContrastModel => _darkMediumContrastModel;
  ThemeModel get darkHighContrastModel => _darkHighContrastModel;
  ThemeMode get themeMode => _themeMode;
  ContrastLevel get contrastLevel => _contrastLevel;

  // Obtenir le thème light en fonction du niveau de contraste
  ThemeData get lightTheme {
    if (_useFlexColorScheme) {
      return FlexThemeData.light(
        scheme: _flexScheme,
        useMaterial3: _useMaterial3,
        blendLevel: _blendLevel.toInt(),
        appBarElevation: 0.5,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // Vous pouvez personnaliser davantage ici
      );
    } else {
      // Utiliser votre logique existante
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          return _materialTheme.light();
        case ContrastLevel.medium:
          return _materialTheme.lightMediumContrast();
        case ContrastLevel.high:
          return _materialTheme.lightHighContrast();
      }
    }
  }

  // Méthode pour obtenir le thème dark avec flex_color_scheme
  ThemeData get darkTheme {
    if (_useFlexColorScheme) {
      return FlexThemeData.dark(
        scheme: _flexScheme,
        useMaterial3: _useMaterial3,
        blendLevel: _blendLevel.toInt(),
        appBarElevation: 1,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 15,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // Vous pouvez personnaliser davantage ici
      );
    } else {
      // Utiliser votre logique existante
      switch (_contrastLevel) {
        case ContrastLevel.normal:
          return _materialTheme.dark();
        case ContrastLevel.medium:
          return _materialTheme.darkMediumContrast();
        case ContrastLevel.high:
          return _materialTheme.darkHighContrast();
      }
    }
  }
  
  // Méthodes pour modifier les propriétés de flex_color_scheme
  void setFlexScheme(FlexScheme scheme) {
    if (_flexScheme != scheme) {
      _flexScheme = scheme;
      notifyListeners();
    }
  }
  
  void setUseFlexColorScheme(bool use) {
    if (_useFlexColorScheme != use) {
      _useFlexColorScheme = use;
      notifyListeners();
    }
  }
  
  void setBlendLevel(double level) {
    if (_blendLevel != level) {
      _blendLevel = level;
      notifyListeners();
    }
  }
  
  void setUseMaterial3(bool use) {
    if (_useMaterial3 != use) {
      _useMaterial3 = use;
      notifyListeners();
    }
  }
  
  // Pour compatibilité avec main.dart
  ColorScheme get lightColorScheme => lightTheme.colorScheme;
  ColorScheme get darkColorScheme => darkTheme.colorScheme;

  // Méthodes pour modifier le thème
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      print("ThemeController: Theme mode set to $_themeMode");
      notifyListeners();
    }
  }

  void toggleThemeMode() {
    final newMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setThemeMode(newMode);
  }

  void setContrastLevel(ContrastLevel level) {
    if (_contrastLevel != level) {
      _contrastLevel = level;
      print("ThemeController: Contrast level set to $_contrastLevel");
      notifyListeners();
    }
  }

  // Méthode pour mettre à jour une couleur du thème
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
    
    // Ajouter un log pour déboguer
    print("ThemeController: Updating $colorName to $color in ${_themeMode.toString()} mode with ${_contrastLevel.toString()} contrast");
    
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
    }
    
    // Notifier les écouteurs du changement
    notifyListeners();
  }

  // Méthode pour obtenir la couleur actuelle en fonction du mode et du niveau de contraste
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
      default: return isDark ? Colors.black : Colors.white;
    }
  }

  // Méthode pour créer un thème personnalisé basé sur le thème actuel
  ThemeData _createCustomTheme(bool isDark) {
    // Obtenir le thème de base
    ThemeData baseTheme = isDark ? darkTheme : lightTheme;
    ColorScheme baseColorScheme = baseTheme.colorScheme;
    
    // Utiliser le modèle approprié en fonction du niveau de contraste
    ThemeModel modelToUse;
    
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
    
    return baseTheme.copyWith(
      colorScheme: baseColorScheme.copyWith(
        primary: modelToUse.primary,
        onPrimary: modelToUse.onPrimary,
        primaryContainer: modelToUse.primaryContainer,
        onPrimaryContainer: modelToUse.onPrimaryContainer,
        secondary: modelToUse.secondary,
        onSecondary: modelToUse.onSecondary,
        secondaryContainer: modelToUse.secondaryContainer,
        onSecondaryContainer: modelToUse.onSecondaryContainer,
        tertiary: modelToUse.tertiary,
        onTertiary: modelToUse.onTertiary,
        tertiaryContainer: modelToUse.tertiaryContainer,
        onTertiaryContainer: modelToUse.onTertiaryContainer,
        error: modelToUse.error,
        onError: modelToUse.onError,
        errorContainer: modelToUse.errorContainer,
        onErrorContainer: modelToUse.onErrorContainer,
        background: modelToUse.background,
        onBackground: modelToUse.onBackground,
        surface: modelToUse.surface,
        onSurface: modelToUse.onSurface,
      ),
    );
  }

  // Méthode pour obtenir le thème actuel
  ThemeData get currentTheme {
    bool isDark = _themeMode == ThemeMode.dark;
    return _createCustomTheme(isDark);
  }

  // Getters pour les thèmes personnalisés
  ThemeData get customLightTheme => _createCustomTheme(false);
  ThemeData get customDarkTheme => _createCustomTheme(true);
  
  // Getters pour les propriétés de flex_color_scheme
  FlexScheme get flexScheme => _flexScheme;
  bool get useFlexColorScheme => _useFlexColorScheme;
  double get blendLevel => _blendLevel;
  bool get useMaterial3 => _useMaterial3;
}  // Accolade fermante manquante pour la classe ThemeController