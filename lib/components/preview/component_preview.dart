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
    Widget selectableComponent(Widget child, String name, List<String> colorProperties, {String? description}) {
      final isSelected = themeController.selectedComponentInfo?.componentName == name;
      
      return InkWell(
        onTap: () {
          themeController.setSelectedComponent(name, colorProperties);
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
            ],
          ),
        ),
      );
    }
    
    // Contenu en fonction du type de vue
    if (viewType == 'Components') {
      // Ajouter un TabBar pour séparer les composants de base et les composants supplémentaires
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
                  // Vue des composants de base existante
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.start,
                      children: [
                        // Boutons
                        selectableComponent(
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Elevated Button'),
                          ),
                          'Elevated Button',
                          ['primary', 'surfaceContainer', 'surface', 'elevation'],
                          description: 'Utilise surfaceContainer pour le fond et primary pour le texte',
                        ),
                        
                        selectableComponent(
                          FilledButton(
                            onPressed: () {},
                            child: const Text('Filled Button'),
                          ),
                          'Filled Button',
                          ['primary', 'onPrimary'],
                          description: 'Utilise primary pour le fond et onPrimary pour le texte',
                        ),
                        
                        selectableComponent(
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Outlined Button'),
                          ),
                          'Outlined Button',
                          ['primary', 'outline'],
                          description: 'Utilise primary pour le texte et outline pour la bordure',
                        ),
                        
                        selectableComponent(
                          TextButton(
                            onPressed: () {},
                            child: const Text('Text Button'),
                          ),
                          'Text Button',
                          ['primary'],
                          description: 'Utilise primary pour le texte',
                        ),
                        
                        // Cartes
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
                        ),
                        
                        selectableComponent(
                          SizedBox(
                            width: 150,
                            height: 100,
                            child: Card(
                              color: currentTheme.colorScheme.primaryContainer,
                              child: Center(
                                child: Text('Colored Card', 
                                  style: TextStyle(color: currentTheme.colorScheme.onPrimaryContainer),
                                ),
                              ),
                            ),
                          ),
                          'Colored Card',
                          ['primaryContainer', 'onPrimaryContainer'],
                          description: 'Utilise primaryContainer pour le fond et onPrimaryContainer pour le texte',
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
                        ),
                      ],
                    ),
                  ),
                  // Nouvelle vue des composants supplémentaires
                  const AdditionalComponentsView(),
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
  }
}