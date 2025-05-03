# M3 Builder AI - Documentation Complète

## Vue d'ensemble
M3 Builder AI est une application Flutter qui permet de créer, visualiser et éditer des thèmes Material 3, ainsi que de simuler des scénarios de retraite. L'application offre une interface intuitive pour personnaliser les couleurs du thème et visualiser en temps réel l'impact sur différents composants Material 3. Elle inclut un thème personnalisé Oroneo avec support pour les assets SVG et un module complet de simulation retraite.

## Structure du projet
Le projet suit une architecture organisée avec les dossiers principaux suivants :
- lib/ : Contient tout le code source Dart
  - components/ : Widgets réutilisables
  - models/ : Modèles de données
  - theme/ : Logique de gestion des thèmes
  - utils/ : Utilitaires et helpers
  - views/ : Écrans de l'application
    - screens/ : Écrans principaux
      - oroneo_home_screen.dart : Écran d'accueil Oroneo
      - oroneo_fs_dialog_simulation.dart : Dialog de simulation retraite
      - oroneo_simulation_dashboard.dart : Tableau de bord de simulation
    - mobile_preview.dart : Aperçu pour mobile
  - widgets/ : Widgets personnalisés
    - oroneo/ : Widgets spécifiques à Oroneo
  - main.dart : Point d'entrée de l'application

## Fonctionnalités principales

### 1. Simulateur de retraite
- Interface conversationnelle pour la collecte des données
- Analyse des documents (relevé de carrière)
- Calcul personnalisé des droits à la retraite
- Tableau de bord interactif avec :
  - Profil utilisateur expansible
  - Situation actuelle (âge de départ, pension, taux de remplacement)
  - Simulateur avec variables ajustables
  - Visualisation des impacts en temps réel

### 2. Éditeur de thème
- Modification des couleurs primaires, secondaires, tertiaires
- Visualisation en temps réel des changements
- Support des thèmes clairs et sombres
- Thème personnalisé Oroneo préconfiguré

### 3. Vues multiples
- Vue simulation retraite
- Vue tableau de bord
- Aperçu mobile
- Navigation fluide entre les écrans

### 4. Support SVG
- Intégration de logos et icônes SVG
- Gestion des assets avec fallback
- Icônes personnalisées pour l'interface

## Flux de travail typique
1. L'utilisateur accède à la simulation retraite
2. Discussion interactive pour la collecte d'informations
3. Upload et analyse du relevé de carrière
4. Génération de la simulation personnalisée
5. Accès au tableau de bord interactif
6. Possibilité de modifier les variables et voir l'impact

## Détails techniques

### Gestion d'état
- StatefulWidget pour les écrans interactifs
- Gestion locale des états de simulation
- Variables réactives pour les calculs en temps réel

### Design System
- Utilisation cohérente de Material 3
- Composants personnalisés respectant les guidelines
- Thème Oroneo intégré
- Gestion des contrastes et de l'accessibilité

### Composants principaux
- Cards expansibles
- Sliders interactifs
- Switches pour options
- Chips informatifs
- Boutons d'action contextuels

## Dépendances principales
- flutter/material.dart : Framework UI de base
- flutter_svg : Support pour les fichiers SVG
- google_fonts : Intégration de polices web

## Développement futur
- Intégration avec des APIs de calcul retraite
- Export des simulations en PDF
- Sauvegarde des scénarios
- Mode hors ligne
- Support multi-langues

## Notes pour les développeurs
- Respecter la structure des widgets existants
- Utiliser les composants Material 3
- Suivre les conventions de nommage établies
- Maintenir la cohérence du design system