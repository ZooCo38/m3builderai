import 'package:flutter/foundation.dart' show kIsWeb;

/// Classe utilitaire qui fournit des méthodes pour détecter la plateforme
/// sans utiliser dart:io, ce qui est compatible avec le web
class PlatformHelper {
  /// Vérifie si l'application s'exécute sur le web
  static bool get isWeb => kIsWeb;
  
  /// Vérifie si l'application s'exécute sur une plateforme de bureau
  /// Pour le web, nous retournons false
  static bool get isDesktop => !kIsWeb;
  
  /// Vérifie si l'application s'exécute sur une plateforme mobile
  /// Pour le web, nous retournons false
  static bool get isMobile => !kIsWeb && !isDesktop;
  
  /// Méthode pour obtenir le chemin de téléchargement approprié selon la plateforme
  static String getDownloadPath() {
    if (isWeb) {
      return ''; // Sur le web, pas de chemin de téléchargement
    } else if (isDesktop) {
      return 'C:\\Users\\Public\\Downloads'; // Chemin Windows par défaut
    } else {
      return '/storage/emulated/0/Download'; // Chemin Android par défaut
    }
  }
}