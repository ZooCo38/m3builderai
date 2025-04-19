import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/drawer/theme_editor_drawer.dart';
import '../components/preview/component_preview.dart';
import '../theme/theme_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final List<String> _viewTitles = ['Components', 'Mobile', 'Web'];
  
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
                      backgroundColor: Colors.transparent, // Utiliser la couleur du Container parent
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
                        
                        // Bouton de contraste
                        Column(
                          children: [
                            PopupMenuButton<ContrastLevel>(
                              icon: const Icon(Icons.contrast),
                              tooltip: 'Contrast level',
                              onSelected: (ContrastLevel level) {
                                // Modification ici pour s'assurer que le changement est appliqué
                                setState(() {
                                  themeController.setContrastLevel(level);
                                  print("Contrast set to: $level");
                                });
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: ContrastLevel.normal,
                                  child: Text('Normal contrast'),
                                ),
                                const PopupMenuItem(
                                  value: ContrastLevel.medium,
                                  child: Text('Medium contrast'),
                                ),
                                const PopupMenuItem(
                                  value: ContrastLevel.high,
                                  child: Text('High contrast'),
                                ),
                              ],
                            ),
                            const Text(
                              'Contrast',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
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
              Builder(
                builder: (context) => ThemeEditorDrawer(),
              ),
            
            // Contenu principal
            Expanded(
              child: Builder(
                builder: (context) {
                  // Forcer l'application du background pour toutes les vues
                  return Container(
                    color: currentTheme.colorScheme.background,
                    child: ComponentPreview(viewType: _viewTitles[_selectedIndex]),
                  );
                },
              ),
            ),
          ],
        ),
        // Drawer d'édition de thème (accessible via un bouton sur mobile)
        endDrawer: isDesktop ? null : Builder(
          builder: (context) => ThemeEditorDrawer(),
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
}