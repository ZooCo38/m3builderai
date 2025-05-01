import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/drawer/theme_editor_drawer.dart';
import '../components/preview/component_preview.dart';
import '../theme/theme_controller.dart';
import '../widgets/flex_theme_settings.dart';
import '../views/mobile_preview.dart'; // Ajout de l'import pour MobilePreview
import '../views/web_preview.dart'; // Ajout de l'import pour WebPreview si disponible
import '../views/assets_manager.dart'; // Ajout de l'import pour la nouvelle vue de gestion des assets

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final List<String> _viewTitles = ['Components', 'Mobile', 'Web', 'Assets']; // Ajout de 'Assets' dans les titres
  
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final isDesktop = MediaQuery.of(context).size.width > 1100;
    
    // Utiliser le thème personnalisé actuel au lieu du thème par défaut
    final currentTheme = themeController.currentTheme;
    
    return Theme(
      // Appliquer le thème personnalisé à tout le Scaffold et ses enfants
      data: currentTheme,
      child: Scaffold(
        backgroundColor: currentTheme.colorScheme.background, // Forcer la couleur de fond
        body: Row(
          children: [
            // Rail de navigation avec sélecteur de thème
            Container(
              color: currentTheme.colorScheme.surface, // Forcer la couleur du rail
              child: Column(
                children: [
                  Expanded(
                    child: NavigationRail(
                      backgroundColor: Colors.transparent,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.widgets),
                          label: Text('Components'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.smartphone),
                          label: Text('Mobile'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.laptop),
                          label: Text('Web'),
                        ),
                        NavigationRailDestination(
                          // Essayons avec une autre icône pour voir si c'est un problème d'icône spécifique
                          icon: Icon(Icons.folder),
                          label: Text('Assets'),
                        ),
                      ],
                    ),
                  ),
                  
                  // Séparateur
                  const Divider(height: 1),
                  
                  // Sélecteur de thème avec boutons icônes
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bouton Light/Dark
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                themeController.themeMode == ThemeMode.dark 
                                    ? Icons.light_mode 
                                    : Icons.dark_mode,
                              ),
                              onPressed: () {
                                // Approche simplifiée pour changer le thème
                                final newMode = themeController.themeMode == ThemeMode.dark 
                                    ? ThemeMode.light 
                                    : ThemeMode.dark;
                                
                                // Appliquer le changement directement
                                themeController.setThemeMode(newMode);
                                
                                // Forcer la mise à jour de l'interface
                                setState(() {});
                                
                                print("HomeView: Thème changé manuellement à $newMode");
                              },
                              tooltip: 'Toggle theme mode',
                            ),
                            Text(
                              themeController.themeMode == ThemeMode.dark 
                                  ? 'Light' 
                                  : 'Dark',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Bouton de contraste - version verticale
                        Column(
                          children: [
                            // Bouton Standard (Normal)
                            IconButton(
                              icon: Icon(
                                Icons.brightness_5,
                                color: themeController.contrastLevel == ContrastLevel.normal
                                    ? currentTheme.colorScheme.onPrimaryContainer
                                    : currentTheme.colorScheme.onSurface,
                              ),
                              onPressed: () {
                                setState(() {
                                  themeController.setContrastLevel(ContrastLevel.normal);
                                  print("Contrast set to: normal");
                                });
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: themeController.contrastLevel == ContrastLevel.normal
                                    ? currentTheme.colorScheme.primaryContainer
                                    : Colors.transparent,
                                foregroundColor: themeController.contrastLevel == ContrastLevel.normal
                                    ? currentTheme.colorScheme.onPrimaryContainer
                                    : currentTheme.colorScheme.onSurface,
                              ),
                              tooltip: 'Standard contrast',
                            ),
                            Text(
                              'Standard',
                              style: TextStyle(
                                fontSize: 12,
                                color: themeController.contrastLevel == ContrastLevel.normal
                                    ? currentTheme.colorScheme.primary
                                    : currentTheme.colorScheme.onSurface,
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Bouton Medium
                            IconButton(
                              icon: Icon(
                                Icons.brightness_6,
                                color: themeController.contrastLevel == ContrastLevel.medium
                                    ? currentTheme.colorScheme.onPrimaryContainer
                                    : currentTheme.colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () {
                                setState(() {
                                  themeController.setContrastLevel(ContrastLevel.medium);
                                  print("Contrast set to: medium");
                                });
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: themeController.contrastLevel == ContrastLevel.medium
                                    ? currentTheme.colorScheme.primaryContainer
                                    : Colors.transparent,
                                foregroundColor: themeController.contrastLevel == ContrastLevel.medium
                                    ? currentTheme.colorScheme.onPrimaryContainer
                                    : currentTheme.colorScheme.onSurfaceVariant,
                              ),
                              tooltip: 'Medium contrast',
                            ),
                            Text(
                              'Medium',
                              style: TextStyle(
                                fontSize: 12,
                                color: themeController.contrastLevel == ContrastLevel.medium
                                    ? currentTheme.colorScheme.primary
                                    : currentTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Bouton High - correction du style
                            IconButton(
                              icon: Icon(
                                Icons.brightness_7,
                                color: themeController.contrastLevel == ContrastLevel.high
                                    ? currentTheme.colorScheme.onPrimaryContainer
                                    : currentTheme.colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () {
                                setState(() {
                                  themeController.setContrastLevel(ContrastLevel.high);
                                  print("Contrast set to: high");
                                });
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: themeController.contrastLevel == ContrastLevel.high
                                    ? currentTheme.colorScheme.primaryContainer
                                    : Colors.transparent,
                                foregroundColor: themeController.contrastLevel == ContrastLevel.high
                                    ? currentTheme.colorScheme.onPrimaryContainer
                                    : currentTheme.colorScheme.onSurfaceVariant,
                              ),
                              tooltip: 'High contrast',
                            ),
                            Text(
                              'High',
                              style: TextStyle(
                                fontSize: 12,
                                color: themeController.contrastLevel == ContrastLevel.high
                                    ? currentTheme.colorScheme.primary
                                    : currentTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        
                        // Ajout du bouton pour les paramètres FlexColorScheme
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.color_lens),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: FlexThemeSettings(),
                                  ),
                                );
                              },
                              tooltip: 'FlexColorScheme settings',
                            ),
                            const Text(
                              'Flex',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        
                        // Ajout du bouton pour le thème Oroneo
                        const SizedBox(height: 16),
                        _buildOroneoThemeButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Drawer d'édition de thème toujours visible à gauche après le rail
            if (!isDesktop) 
              const SizedBox() 
            else 
              SizedBox(
                width: 300, // Définir une largeur fixe
                child: Column(
                  children: [
                    Expanded(
                      child: ThemeEditorDrawer(),
                    ),
                    // FlexThemeSettings supprimé d'ici
                  ],
                ),
              ),
            
            // Contenu principal
            Expanded(
              child: Builder(
                builder: (context) {
                  // Forcer l'application du background pour toutes les vues
                  return Container(
                    color: currentTheme.colorScheme.background,
                    child: _buildSelectedView(_selectedIndex),
                  );
                },
              ),
            ),
          ],
        ),
        // Drawer d'édition de thème (accessible via un bouton sur mobile)
        endDrawer: isDesktop ? null : Drawer(
          child: Column(
            children: [
              Expanded(
                child: ThemeEditorDrawer(),
              ),
              // FlexThemeSettings supprimé d'ici
            ],
          ),
        ),
        floatingActionButton: isDesktop 
            ? null 
            : FloatingActionButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(Icons.palette),
                tooltip: 'Edit Theme',
              ),
      ),
    );
  }

  // Nouvelle méthode pour construire la vue sélectionnée
  Widget _buildSelectedView(int index) {
    switch (index) {
      case 0:
        return ComponentPreview(viewType: _viewTitles[index]);
      case 1:
        return const MobilePreview();
      case 2:
        return const WebPreview();
      case 3:
        return const AssetsManager(); // Nouvelle vue pour la gestion des assets
      default:
        return ComponentPreview(viewType: _viewTitles[0]);
    }
  }

  // Méthode pour construire le bouton de thème Oroneo
  Widget _buildOroneoThemeButton() {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    
    return Column(
      children: [
        IconButton(
          icon: SvgPicture.asset(
            themeController.useOroneoTheme
                ? 'assets/oroneo/logos/Odark.svg'
                : 'assets/oroneo/logos/Olight.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              themeController.useOroneoTheme
                  ? currentTheme.colorScheme.onPrimaryContainer
                  : currentTheme.colorScheme.onSurfaceVariant,
              BlendMode.srcIn
            ),
          ),
          tooltip: 'Basculer vers le thème Oroneo',
          onPressed: () {
            Provider.of<ThemeController>(context, listen: false).toggleOroneoTheme();
          },
          style: IconButton.styleFrom(
            backgroundColor: themeController.useOroneoTheme
                ? currentTheme.colorScheme.primaryContainer
                : Colors.transparent,
          ),
        ),
        Text(
          'Oroneo',
          style: TextStyle(
            fontSize: 12,
            color: themeController.useOroneoTheme
                ? currentTheme.colorScheme.primary
                : currentTheme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}