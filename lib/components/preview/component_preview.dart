import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_controller.dart';
import 'additional_components.dart';

class ComponentPreview extends StatelessWidget {
  final String viewType;
  
  const ComponentPreview({super.key, required this.viewType});
  
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = Theme.of(context);
    
    // Fonction pour créer un widget cliquable qui met à jour la sélection
    Widget selectableComponent(
      Widget child, 
      String name, 
      List<String> colorProperties, {
      String? description,
      List<String> hoverColorProperties = const [],
      List<String> pressedColorProperties = const [],
    }) {
      final isSelected = themeController.selectedComponentInfo?.componentName == name;
      
      return InkWell(
        onTap: () {
          themeController.setSelectedComponent(
            name, 
            colorProperties,
            hoverColorProperties: hoverColorProperties,
            pressedColorProperties: pressedColorProperties,
          );
        },
        child: Container(
          width: 200, // Largeur fixe pour une meilleure disposition
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: currentTheme.colorScheme.primary, width: 2)
                : Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
            color: currentTheme.colorScheme.surface,
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: child),
              const SizedBox(height: 12),
              Text(name, 
                style: currentTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    description,
                    style: currentTheme.textTheme.bodySmall,
                  ),
                ),
              const SizedBox(height: 8),
              
              // État par défaut
              Text('État par défaut:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: colorProperties.map((prop) => 
                  Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    label: Text(prop, style: const TextStyle(fontSize: 10)),
                    backgroundColor: currentTheme.colorScheme.surfaceVariant,
                    padding: EdgeInsets.zero,
                  )
                ).toList(),
              ),
              
              // État hover
              if (hoverColorProperties.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text('État hover:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: hoverColorProperties.map((prop) => 
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      label: Text(prop, style: const TextStyle(fontSize: 10)),
                      backgroundColor: currentTheme.colorScheme.tertiaryContainer.withOpacity(0.5),
                      padding: EdgeInsets.zero,
                    )
                  ).toList(),
                ),
              ],
              
              // État pressed
              if (pressedColorProperties.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text('État pressed:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: pressedColorProperties.map((prop) => 
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      label: Text(prop, style: const TextStyle(fontSize: 10)),
                      backgroundColor: currentTheme.colorScheme.secondaryContainer.withOpacity(0.5),
                      padding: EdgeInsets.zero,
                    )
                  ).toList(),
                ),
              ],
            ],
          ),
        ),
      );
    }
    
    // Fonction pour générer les composants d'une section colorée (primary, secondary, tertiary)
    List<Widget> buildComponentsForSection(String sectionType, ThemeData theme) {
      // Définir les couleurs en fonction du type de section
      Color mainColor;
      Color containerColor;
      Color onContainerColor;
      
      switch(sectionType) {
        case 'primary':
          mainColor = theme.colorScheme.primary;
          containerColor = theme.colorScheme.primaryContainer;
          onContainerColor = theme.colorScheme.onPrimaryContainer;
          break;
        case 'secondary':
          mainColor = theme.colorScheme.secondary;
          containerColor = theme.colorScheme.secondaryContainer;
          onContainerColor = theme.colorScheme.onSecondaryContainer;
          break;
        case 'tertiary':
          mainColor = theme.colorScheme.tertiary;
          containerColor = theme.colorScheme.tertiaryContainer;
          onContainerColor = theme.colorScheme.onTertiaryContainer;
          break;
        default:
          mainColor = theme.colorScheme.primary;
          containerColor = theme.colorScheme.primaryContainer;
          onContainerColor = theme.colorScheme.onPrimaryContainer;
      }
      
      // Extension pour capitaliser les chaînes
      String capitalize(String s) => s.isEmpty ? '' : '${s[0].toUpperCase()}${s.substring(1)}';
      String capitalizedSection = capitalize(sectionType);
      
      // Créer la liste des composants avec les couleurs appropriées
      return [
        // Elevated Button
        selectableComponent(
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: mainColor,
            ),
            child: Text('$capitalizedSection Elevated'),
          ),
          '$capitalizedSection Elevated Button',
          [sectionType, 'surfaceContainer', 'surface', 'elevation'],
          description: 'Utilise surfaceContainer pour le fond et $sectionType pour le texte',
          hoverColorProperties: [sectionType, 'surfaceContainer', 'shadow'],
          pressedColorProperties: [sectionType, 'surfaceContainer', 'shadow', 'onSurface'],
        ),
        
        // Filled Button
        selectableComponent(
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: mainColor,
            ),
            child: Text('$capitalizedSection Filled'),
          ),
          '$capitalizedSection Filled Button',
          [sectionType, 'on$capitalizedSection'],
          description: 'Utilise $sectionType pour le fond et on$sectionType pour le texte',
          hoverColorProperties: [sectionType, 'on$capitalizedSection', 'shadow'],
          pressedColorProperties: [sectionType, 'on$capitalizedSection', 'shadow'],
        ),
        
        // Outlined Button
        selectableComponent(
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: mainColor,
            ),
            child: Text('$capitalizedSection Outlined'),
          ),
          '$capitalizedSection Outlined Button',
          [sectionType, 'outline'],
          description: 'Utilise $sectionType pour le texte et outline pour la bordure',
          hoverColorProperties: [sectionType, 'outline', 'surfaceContainer'],
          pressedColorProperties: [sectionType, 'outline', 'surfaceContainer'],
        ),
        
        // Text Button
        selectableComponent(
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: mainColor,
            ),
            child: Text('$capitalizedSection Text'),
          ),
          '$capitalizedSection Text Button',
          [sectionType],
          description: 'Utilise $sectionType pour le texte',
          hoverColorProperties: [sectionType, 'surfaceContainer'],
          pressedColorProperties: [sectionType, 'surfaceContainer'],
        ),
        
        // Colored Card
        selectableComponent(
          SizedBox(
            width: 150,
            height: 100,
            child: Card(
              color: containerColor,
              child: Center(
                child: Text('$capitalizedSection Card', 
                  style: TextStyle(color: onContainerColor),
                ),
              ),
            ),
          ),
          '$capitalizedSection Card',
          ['${sectionType}Container', 'on${sectionType}Container'],
          description: 'Utilise ${sectionType}Container pour le fond et on${sectionType}Container pour le texte',
          hoverColorProperties: ['${sectionType}Container', 'on${sectionType}Container', 'elevation'],
          pressedColorProperties: ['${sectionType}Container', 'on${sectionType}Container', 'elevation'],
        ),
        
        // Extended FAB
        selectableComponent(
          FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: mainColor,
            foregroundColor: theme.colorScheme.onPrimary,
            icon: const Icon(Icons.add),
            label: Text('$capitalizedSection Extended'),
          ),
          '$capitalizedSection Extended FAB',
          [sectionType, 'on$capitalizedSection', 'surface', 'elevation'],
          description: 'Utilise $sectionType pour le fond et on$sectionType pour le texte et l\'icône',
          hoverColorProperties: [sectionType, 'on$capitalizedSection', 'shadow'],
          pressedColorProperties: [sectionType, 'on$capitalizedSection', 'shadow'],
        ),
        
        // FAB standard
        selectableComponent(
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: mainColor,
            foregroundColor: theme.colorScheme.onPrimary,
            child: const Icon(Icons.add),
          ),
          '$capitalizedSection FAB',
          [sectionType, 'on$capitalizedSection', 'surface', 'elevation'],
          description: 'Utilise $sectionType pour le fond et on$sectionType pour l\'icône',
          hoverColorProperties: [sectionType, 'on$capitalizedSection', 'shadow'],
          pressedColorProperties: [sectionType, 'on$capitalizedSection', 'shadow'],
        ),
        
        // Icon Buttons
        selectableComponent(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                color: mainColor,
                icon: const Icon(Icons.favorite),
              ),
              IconButton.filled(
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: mainColor,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                icon: const Icon(Icons.favorite),
              ),
              IconButton.outlined(
                onPressed: () {},
                style: IconButton.styleFrom(
                  foregroundColor: mainColor,
                ),
                icon: const Icon(Icons.favorite),
              ),
            ],
          ),
          '$capitalizedSection Icon Buttons',
          [sectionType, 'on$capitalizedSection', 'surface', 'surfaceContainer'],
          description: 'Standard, Filled et Outlined',
          hoverColorProperties: [sectionType, 'on$capitalizedSection', 'surfaceContainer'],
          pressedColorProperties: [sectionType, 'on$capitalizedSection', 'surfaceContainer'],
        ),
        
        // Text Input
        selectableComponent(
          SizedBox(
            width: 180,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: '$capitalizedSection Input',
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(color: mainColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          '$capitalizedSection Text Input',
          [sectionType, 'onSurface', 'surfaceVariant', 'outline'],
          description: 'Utilise $sectionType pour la mise en évidence',
          hoverColorProperties: [sectionType, 'onSurface', 'surfaceVariant'],
          pressedColorProperties: [sectionType, 'onSurface', 'surfaceVariant', 'onSurfaceVariant'],
        ),
      ];
    }
    
    // Contenu en fonction du type de vue
    if (viewType == 'Components') {
      // Définir les sections de couleur à afficher
      final colorSections = [
        {
          'type': 'primary',
          'title': 'Composants Primary',
          'color': currentTheme.colorScheme.primary,
          'containerColor': currentTheme.colorScheme.primaryContainer.withOpacity(0.15),
        },
        {
          'type': 'secondary',
          'title': 'Composants Secondary',
          'color': currentTheme.colorScheme.secondary,
          'containerColor': currentTheme.colorScheme.secondaryContainer.withOpacity(0.15),
        },
        {
          'type': 'tertiary',
          'title': 'Composants Tertiary',
          'color': currentTheme.colorScheme.tertiary,
          'containerColor': currentTheme.colorScheme.tertiaryContainer.withOpacity(0.15),
        },
      ];
      
      return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(text: 'Composants de base'),
                Tab(text: 'Composants supplémentaires'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Vue des composants de base
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Générer les sections de couleur avec une boucle
                            ...colorSections.map((section) => Card(
                              color: section['containerColor'] as Color,
                              margin: const EdgeInsets.only(bottom: 24),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        section['title'] as String,
                                        style: currentTheme.textTheme.titleLarge?.copyWith(
                                          color: section['color'] as Color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      alignment: WrapAlignment.start,
                                      children: buildComponentsForSection(section['type'] as String, currentTheme),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            
                            // Section Neutral/Surface
                            Card(
                              color: currentTheme.colorScheme.surfaceVariant.withOpacity(0.15),
                              margin: const EdgeInsets.only(bottom: 24),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        'Composants Neutres',
                                        style: currentTheme.textTheme.titleLarge?.copyWith(
                                          color: currentTheme.colorScheme.onSurfaceVariant,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      alignment: WrapAlignment.start,
                                      children: [
                                        // Carte standard
                                        selectableComponent(
                                          SizedBox(
                                            width: 150,
                                            height: 100,
                                            child: Card(
                                              child: Center(
                                                child: Text('Card', style: currentTheme.textTheme.titleMedium),
                                              ),
                                            ),
                                          ),
                                          'Card',
                                          ['surface', 'onSurface', 'surfaceVariant', 'onSurfaceVariant'],
                                          description: 'Utilise surface pour le fond et onSurface pour le texte',
                                          hoverColorProperties: ['surface', 'onSurface', 'elevation'],
                                          pressedColorProperties: ['surface', 'onSurface', 'elevation'],
                                        ),
                                        
                                        // Champs de texte
                                        selectableComponent(
                                          SizedBox(
                                            width: 180,
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                labelText: 'TextField',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          'TextField',
                                          ['primary', 'onSurface', 'surfaceVariant'],
                                          description: 'Utilise primary pour la mise en évidence, onSurface pour le texte',
                                          hoverColorProperties: ['primary', 'onSurface', 'surfaceVariant'],
                                          pressedColorProperties: ['primary', 'onSurface', 'surfaceVariant', 'onSurfaceVariant'],
                                        ),
                                        
                                        // Chips
                                        selectableComponent(
                                          Wrap(
                                            spacing: 8,
                                            children: [
                                              const Chip(label: Text('Chip')),
                                              FilterChip(
                                                label: const Text('Filter'),
                                                selected: true,
                                                onSelected: (_) {},
                                              ),
                                            ],
                                          ),
                                          'Chips',
                                          ['surfaceVariant', 'onSurfaceVariant', 'primary'],
                                          description: 'Utilise surfaceVariant pour le fond et onSurfaceVariant pour le texte',
                                          hoverColorProperties: ['surfaceVariant', 'onSurfaceVariant', 'primary'],
                                          pressedColorProperties: ['surfaceVariant', 'onSurfaceVariant', 'primary', 'surface'],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Vue des composants supplémentaires
                  AdditionalComponents(selectableComponent: selectableComponent),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (viewType == 'Mobile') {
      // Code pour la vue Mobile
      return Center(
        child: Text('Vue Mobile à implémenter', style: currentTheme.textTheme.headlineMedium),
      );
    } else {
      // Code pour la vue Web
      return Center(
        child: Text('Vue Web à implémenter', style: currentTheme.textTheme.headlineMedium),
      );
    }
  } // Fermeture de la méthode build
} // Fermeture de la classe ComponentPreview