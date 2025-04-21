# M3 Builder AI - Documentation Complète

## Vue d'ensemble
M3 Builder AI est une application Flutter qui permet de créer, visualiser et éditer des thèmes Material 3. L'application offre une interface intuitive pour personnaliser les couleurs du thème et visualiser en temps réel l'impact sur différents composants Material 3.

## Structure du projet
Le projet suit une architecture organisée avec les dossiers principaux suivants :
- lib/ : Contient tout le code source Dart
  - components/ : Widgets réutilisables
    - drawer/ : Composants pour les tiroirs latéraux (dont theme_editor_drawer.dart)
    - preview/ : Composants pour l'aperçu des thèmes
  - models/ : Modèles de données
    - theme_model.dart : Définition du modèle de thème
  - theme/ : Logique de gestion des thèmes
    - material_theme.dart : Implémentation du thème Material 3
    - theme_controller.dart : Gère l'état du thème dans l'application
    - theme_export.dart : Fonctionnalités d'exportation de thèmes
    - theme_import.dart : Fonctionnalités d'importation de thèmes
  - utils/ : Utilitaires et helpers
    - file_picker_adapter.dart : Adaptation pour la sélection de fichiers
    - file_picker_web.dart : Implémentation spécifique pour le web
    - platform_helper.dart : Fonctions spécifiques aux plateformes
  - views/ : Écrans de l'application
    - components_view.dart : Vue des composants Material 3
    - home_view.dart : Écran principal
    - mobile_preview.dart : Aperçu pour mobile
    - web_preview.dart : Aperçu pour web
  - widgets/ : Widgets personnalisés
    - hex_color_field.dart : Champ pour éditer les couleurs hexadécimales
  - main.dart : Point d'entrée de l'application

## Fonctionnalités principales

### 1. Éditeur de thème
- Modification des couleurs primaires, secondaires, tertiaires, d'erreur, etc.
- Visualisation en temps réel des changements
- Édition directe des codes hexadécimaux des couleurs via hex_color_field.dart
- Support des thèmes clairs et sombres

### 2. Importation/Exportation de thèmes
- Importation de thèmes depuis différents formats (JSON, Dart, XML, CSS)
- Exportation de thèmes vers différents formats
- Sauvegarde locale des thèmes
- Adaptation pour le web via file_picker_web.dart

### 3. Vues multiples
- Vue des composants (components_view.dart)
- Aperçu mobile (mobile_preview.dart)
- Aperçu web (web_preview.dart)
- Vue d'accueil (home_view.dart)

## Flux de travail typique
1. L'utilisateur ouvre l'application et voit les composants Material 3 avec le thème par défaut
2. L'utilisateur peut ouvrir le tiroir d'édition de thème pour modifier les couleurs
3. Les modifications sont appliquées en temps réel sur les composants
4. L'utilisateur peut basculer entre différentes vues pour voir l'impact du thème
5. L'utilisateur peut importer un thème existant ou exporter le thème créé

## Détails techniques

### Gestion d'état
- Utilisation de Provider pour la gestion d'état du thème
- ThemeController centralise la logique de gestion des thèmes

### Compatibilité multi-plateformes
- Support pour Web, Android, iOS, et desktop
- Adaptations spécifiques pour le web dans file_picker_web.dart et platform_helper.dart

### Déploiement
- Version web déployée sur GitHub Pages : https://zooco38.github.io/m3builderai/
- Base href configurée pour le chemin /m3builderai/

## Dépendances principales
- flutter/material.dart : Framework UI de base
- provider : Gestion d'état
- file_picker : Sélection de fichiers pour import/export

## Développement futur
- Intégration avec l'API Material Theme Builder de Google
- Génération de thèmes à l'aide d'IA
- Support pour l'accessibilité et les contrastes
- Sauvegarde des thèmes dans le cloud

## Notes pour les développeurs
- Les modifications de couleur sont gérées via ThemeController
- L'exportation de thèmes supporte plusieurs formats via ThemeExporter
- L'application utilise Material 3 (Material You) pour tous les composants
- Le modèle de thème est défini dans theme_model.dart