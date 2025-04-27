import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import '../models/theme_model.dart';
import 'material_theme.dart';
import '../themes/oroneo_theme.dart';

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
  final List<String> hoverColorProperties;
  final List<String> pressedColorProperties;
  
  ComponentInfo(
    this.componentName, 
    this.usedColorProperties, {
    this.hoverColorProperties = const [],
    this.pressedColorProperties = const [],
  });
}

class ThemeController extends ChangeNotifier {
  // Propriété pour le thème Oroneo
  bool _useOroneoTheme = false;
  bool get useOroneoTheme => _useOroneoTheme;
  
  // Méthode pour basculer entre le thème standard et le thème Oroneo
  void toggleOroneoTheme() {
    _useOroneoTheme = !_useOroneoTheme;
    
    if (_useOroneoTheme) {
      // Charger les couleurs Oroneo dans les modèles
      loadOroneoThemeIntoModels();
    } else {
      // Réinitialiser les thèmes
      _initializeThemes();
    }
    
    // Notifier les écouteurs pour mettre à jour l'interface
    notifyListeners();
  }
  
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
    
    // Nous n'avons plus besoin d'ajuster les contrastes car nous utilisons les schémas prédéfinis
    // _adjustContrastForModels();
  }
  
  // Initialiser les thèmes
  void _initializeThemes() {
    // Utiliser les schémas de couleurs prédéfinis de MaterialTheme
    final lightScheme = MaterialTheme.lightScheme().toColorScheme();
    final darkScheme = MaterialTheme.darkScheme().toColorScheme();
    final lightMediumContrastScheme = MaterialTheme.lightMediumContrastScheme().toColorScheme();
    final lightHighContrastScheme = MaterialTheme.lightHighContrastScheme().toColorScheme();
    final darkMediumContrastScheme = MaterialTheme.darkMediumContrastScheme().toColorScheme();
    final darkHighContrastScheme = MaterialTheme.darkHighContrastScheme().toColorScheme();
    
    // Initialiser le thème clair normal
    _initializeThemeModel(_currentThemeModel, lightScheme);
    
    // Initialiser le thème sombre normal
    _initializeThemeModel(_darkThemeModel, darkScheme);
    
    // Initialiser les thèmes à contraste moyen
    _initializeThemeModel(_lightMediumContrastModel, lightMediumContrastScheme);
    _initializeThemeModel(_darkMediumContrastModel, darkMediumContrastScheme);
    
    // Initialiser les thèmes à contraste élevé
    _initializeThemeModel(_lightHighContrastModel, lightHighContrastScheme);
    _initializeThemeModel(_darkHighContrastModel, darkHighContrastScheme);
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
    
    // Même si le thème Oroneo est activé, nous utilisons les modèles modifiés
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
  
  // GARDER uniquement ces getters pour les thèmes light et dark
  ThemeData get lightTheme {
    if (_useOroneoTheme) {
      // Créer une instance de ThemeData avec les couleurs Oroneo
      final baseTheme = ThemeData.light(useMaterial3: true);
      return OroneoTheme.lightTheme(baseTheme);
    } else if (_useFlexColorScheme) {
      return _createFlexTheme(Brightness.light);
    } else {
      return ThemeData(
        useMaterial3: _useMaterial3,
        colorScheme: _currentThemeModel.toColorScheme(Brightness.light),
        brightness: Brightness.light,
      );
    }
  }
  
  ThemeData get darkTheme {
    if (_useOroneoTheme) {
      // Créer une instance de ThemeData avec les couleurs Oroneo
      final baseTheme = ThemeData.dark(useMaterial3: true);
      return OroneoTheme.darkTheme(baseTheme);
    } else if (_useFlexColorScheme) {
      return _createFlexTheme(Brightness.dark);
    } else {
      return ThemeData(
        useMaterial3: _useMaterial3,
        colorScheme: _darkThemeModel.toColorScheme(Brightness.dark),
        brightness: Brightness.dark,
      );
    }
  }
  
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
  
  // Définir le mode de thème
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  
  // Définir le niveau de contraste
  void setContrastLevel(ContrastLevel level) {
    _contrastLevel = level;
    
    // Pas besoin de régénérer les thèmes, car nous utilisons déjà les modèles
    // appropriés dans les méthodes currentTheme, lightTheme et darkTheme
    
    notifyListeners();
  }
  
  // Méthode pour ajuster le contraste des modèles existants
  void _adjustContrastForModels() {
    // Ajuster le contraste pour les modèles medium
    _adjustModelContrast(_lightMediumContrastModel, _currentThemeModel, 0.1);
    _adjustModelContrast(_darkMediumContrastModel, _darkThemeModel, 0.1);
    
    // Ajuster le contraste pour les modèles high
    _adjustModelContrast(_lightHighContrastModel, _currentThemeModel, 0.2);
    _adjustModelContrast(_darkHighContrastModel, _darkThemeModel, 0.2);
  }
  
  // Méthode pour ajuster le contraste d'un modèle
  void _adjustModelContrast(ThemeModel targetModel, ThemeModel baseModel, double factor) {
    // Copier toutes les couleurs du modèle de base
    targetModel.primary = baseModel.primary;
    targetModel.primaryContainer = baseModel.primaryContainer;
    targetModel.secondary = baseModel.secondary;
    targetModel.secondaryContainer = baseModel.secondaryContainer;
    targetModel.tertiary = baseModel.tertiary;
    targetModel.tertiaryContainer = baseModel.tertiaryContainer;
    targetModel.error = baseModel.error;
    targetModel.errorContainer = baseModel.errorContainer;
    targetModel.background = baseModel.background;
    targetModel.onBackground = baseModel.onBackground;
    targetModel.surface = baseModel.surface;
    targetModel.onSurface = baseModel.onSurface;
    targetModel.surfaceVariant = baseModel.surfaceVariant;
    targetModel.onSurfaceVariant = baseModel.onSurfaceVariant;
    targetModel.outline = baseModel.outline;
    targetModel.outlineVariant = baseModel.outlineVariant;
    
    // Ajuster les couleurs "on" pour augmenter le contraste
    targetModel.onBackground = _increaseContrast(baseModel.onBackground, baseModel.background, factor);
    targetModel.onSurface = _increaseContrast(baseModel.onSurface, baseModel.surface, factor);
    targetModel.onPrimary = _increaseContrast(baseModel.onPrimary, baseModel.primary, factor);
    targetModel.onSecondary = _increaseContrast(baseModel.onSecondary, baseModel.secondary, factor);
    targetModel.onTertiary = _increaseContrast(baseModel.onTertiary, baseModel.tertiary, factor);
    targetModel.onPrimaryContainer = _increaseContrast(baseModel.onPrimaryContainer, baseModel.primaryContainer, factor);
    targetModel.onSecondaryContainer = _increaseContrast(baseModel.onSecondaryContainer, baseModel.secondaryContainer, factor);
    targetModel.onTertiaryContainer = _increaseContrast(baseModel.onTertiaryContainer, baseModel.tertiaryContainer, factor);
    targetModel.onError = _increaseContrast(baseModel.onError, baseModel.error, factor);
    targetModel.onErrorContainer = _increaseContrast(baseModel.onErrorContainer, baseModel.errorContainer, factor);
    targetModel.onSurfaceVariant = _increaseContrast(baseModel.onSurfaceVariant, baseModel.surfaceVariant, factor);
  }
  
  // Méthode pour obtenir le thème Oroneo
  ThemeData getOroneoTheme(bool isDark) {
    // Obtenez d'abord le thème de base (Material 3)
    ThemeData baseTheme = isDark ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
    
    // Appliquez les personnalisations Oroneo
    return isDark ? OroneoTheme.darkTheme(baseTheme) : OroneoTheme.lightTheme(baseTheme);
  }
  
  // Ajouter cette nouvelle méthode pour charger le thème Oroneo dans les modèles
  void loadOroneoThemeIntoModels() {
    if (_useOroneoTheme) {
      // Créer des instances de ThemeData pour les thèmes Oroneo
      final lightBaseTheme = ThemeData.light(useMaterial3: true);
      final darkBaseTheme = ThemeData.dark(useMaterial3: true);
      
      final oroneoLightTheme = OroneoTheme.lightTheme(lightBaseTheme);
      final oroneoDarkTheme = OroneoTheme.darkTheme(darkBaseTheme);
      
      // Charger les couleurs du thème Oroneo light dans le modèle light
      _loadThemeDataIntoModel(oroneoLightTheme, _currentThemeModel);
      
      // Charger les couleurs du thème Oroneo dark dans le modèle dark
      _loadThemeDataIntoModel(oroneoDarkTheme, _darkThemeModel);
      
      // Pour les contrastes, on pourrait créer des versions à contraste élevé
      // mais pour l'instant, utilisons les mêmes modèles
      _loadThemeDataIntoModel(oroneoLightTheme, _lightMediumContrastModel);
      _loadThemeDataIntoModel(oroneoLightTheme, _lightHighContrastModel);
      _loadThemeDataIntoModel(oroneoDarkTheme, _darkMediumContrastModel);
      _loadThemeDataIntoModel(oroneoDarkTheme, _darkHighContrastModel);
    }
  }
  
  // Méthode helper pour charger un ThemeData dans un ThemeModel
  void _loadThemeDataIntoModel(ThemeData themeData, ThemeModel model) {
    final colorScheme = themeData.colorScheme;
    
    model.primary = colorScheme.primary;
    model.onPrimary = colorScheme.onPrimary;
    model.primaryContainer = colorScheme.primaryContainer;
    model.onPrimaryContainer = colorScheme.onPrimaryContainer;
    
    model.secondary = colorScheme.secondary;
    model.onSecondary = colorScheme.onSecondary;
    model.secondaryContainer = colorScheme.secondaryContainer;
    model.onSecondaryContainer = colorScheme.onSecondaryContainer;
    
    model.tertiary = colorScheme.tertiary;
    model.onTertiary = colorScheme.onTertiary;
    model.tertiaryContainer = colorScheme.tertiaryContainer;
    model.onTertiaryContainer = colorScheme.onTertiaryContainer;
    
    model.error = colorScheme.error;
    model.onError = colorScheme.onError;
    model.errorContainer = colorScheme.errorContainer;
    model.onErrorContainer = colorScheme.onErrorContainer;
    
    model.background = colorScheme.background;
    model.onBackground = colorScheme.onBackground;
    
    model.surface = colorScheme.surface;
    model.onSurface = colorScheme.onSurface;
    model.surfaceVariant = colorScheme.surfaceVariant;
    model.onSurfaceVariant = colorScheme.onSurfaceVariant;
    
    model.outline = colorScheme.outline;
    model.outlineVariant = colorScheme.outlineVariant;
    
    // Nouvelles propriétés pour Material 3
    model.surfaceContainer = colorScheme.surface.withOpacity(0.9);
    model.surfaceContainerLow = colorScheme.surface.withOpacity(0.95);
    model.surfaceContainerHigh = colorScheme.surface.withOpacity(0.85);
    model.surfaceContainerHighest = colorScheme.surface.withOpacity(0.8);
    model.surfaceBright = colorScheme.brightness == Brightness.light ? Colors.white : Colors.grey.shade900;
    model.surfaceDim = colorScheme.brightness == Brightness.light ? Colors.grey.shade50 : Colors.grey.shade800;
    model.elevation = colorScheme.brightness == Brightness.light ? Colors.black12 : Colors.white12;
  }
  
  // Garder la méthode _increaseContrast et _isDark
  Color _increaseContrast(Color foreground, Color background, double factor) {
    // Si le texte est déjà sombre sur fond clair ou clair sur fond sombre, augmenter le contraste
    if (_isDark(background) && !_isDark(foreground)) {
      // Éclaircir davantage le texte clair
      return Color.lerp(foreground, Colors.white, factor)!;
    } else if (!_isDark(background) && _isDark(foreground)) {
      // Assombrir davantage le texte sombre
      return Color.lerp(foreground, Colors.black, factor)!;
    }
    return foreground;
  }
  
  bool _isDark(Color color) {
    // Calculer la luminosité (0 = noir, 1 = blanc)
    final luminance = color.computeLuminance();
    return luminance < 0.5;
  }
  
  // Définir le composant sélectionné
  void setSelectedComponent(
    String name, 
    List<String> colorProperties, {
    List<String> hoverColorProperties = const [],
    List<String> pressedColorProperties = const [],
  }) {
    _selectedComponentInfo = ComponentInfo(
      name, 
      colorProperties,
      hoverColorProperties: hoverColorProperties,
      pressedColorProperties: pressedColorProperties,
    );
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
    
    // Mettre à jour la couleur dans le modèle
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
      // Ajouter les cas pour les nouvelles couleurs
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
      case 'shadow':
        modelToUpdate.shadow = color;
        break;
      case 'scrim':
        modelToUpdate.scrim = color;
        break;
      case 'inverseSurface':
        modelToUpdate.inverseSurface = color;
        break;
      case 'onInverseSurface':
        modelToUpdate.onInverseSurface = color;
        break;
      case 'inversePrimary':
        modelToUpdate.inversePrimary = color;
        break;
    }
    
    // Notifier les écouteurs pour mettre à jour l'interface
    notifyListeners();
  }
  
  // Obtenir une couleur du thème actuel
  Color getCurrentColor(String colorName) {
    // Obtenir le modèle approprié en fonction du mode et du niveau de contraste
    final model = _getModelForCurrentSettings();
    
    // Retourner la couleur demandée
    switch (colorName) {
      case 'primary':
        return model.primary;
      case 'onPrimary':
        return model.onPrimary;
      case 'primaryContainer':
        return model.primaryContainer;
      case 'onPrimaryContainer':
        return model.onPrimaryContainer;
      case 'secondary':
        return model.secondary;
      case 'onSecondary':
        return model.onSecondary;
      case 'secondaryContainer':
        return model.secondaryContainer;
      case 'onSecondaryContainer':
        return model.onSecondaryContainer;
      case 'tertiary':
        return model.tertiary;
      case 'onTertiary':
        return model.onTertiary;
      case 'tertiaryContainer':
        return model.tertiaryContainer;
      case 'onTertiaryContainer':
        return model.onTertiaryContainer;
      case 'error':
        return model.error;
      case 'onError':
        return model.onError;
      case 'errorContainer':
        return model.errorContainer;
      case 'onErrorContainer':
        return model.onErrorContainer;
      case 'background':
        return model.background;
      case 'onBackground':
        return model.onBackground;
      case 'surface':
        return model.surface;
      case 'onSurface':
        return model.onSurface;
      case 'surfaceVariant':
        return model.surfaceVariant;
      case 'onSurfaceVariant':
        return model.onSurfaceVariant;
      case 'outline':
        return model.outline;
      case 'outlineVariant':
        return model.outlineVariant;
      // Ajouter les cas pour les nouvelles couleurs
      case 'surfaceContainer':
        return model.surfaceContainer;
      case 'surfaceContainerLow':
        return model.surfaceContainerLow;
      case 'surfaceContainerHigh':
        return model.surfaceContainerHigh;
      case 'surfaceContainerHighest':
        return model.surfaceContainerHighest;
      case 'surfaceBright':
        return model.surfaceBright;
      case 'surfaceDim':
        return model.surfaceDim;
      case 'elevation':
        return model.elevation;
      case 'shadow':
        return model.shadow ?? Colors.black.withOpacity(0.3);
      case 'scrim':
        return model.scrim ?? Colors.black.withOpacity(0.5);
      case 'inverseSurface':
        return model.inverseSurface ?? (_themeMode == ThemeMode.dark ? Colors.white : Colors.black);
      case 'onInverseSurface':
        return model.onInverseSurface ?? (_themeMode == ThemeMode.dark ? Colors.black : Colors.white);
      case 'inversePrimary':
        return model.inversePrimary ?? model.primary.withOpacity(0.8);
      default:
        return Colors.transparent;
    }
  }
}
