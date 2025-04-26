import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_controller.dart';

class ComponentsView extends StatelessWidget {
  const ComponentsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenir le ThemeController
    final themeController = Provider.of<ThemeController>(context);
    
    // Utiliser directement le thème actuel sans surcharge
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      // Laisser Scaffold utiliser les couleurs par défaut du thème
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre avec la couleur primaire du thème actuel
            Text(
              'Material 3 Components',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Buttons Section
            _buildSectionTitle(context, 'Buttons'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // Personnaliser l'ElevatedButton pour utiliser les couleurs du ThemeController
                ElevatedButton(
                  onPressed: () {},
                  // Utiliser un style personnalisé qui inclut la couleur d'élévation
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.getCurrentColor('surfaceContainer'),
                    foregroundColor: themeController.getCurrentColor('primary'),
                    elevation: 4, // Définir une élévation visible
                    shadowColor: themeController.getCurrentColor('elevation'),
                  ),
                  child: const Text('Elevated Button'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled Button'),
                ),
                FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('Filled Tonal'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined Button'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text Button'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Icon Buttons
            _buildSectionTitle(context, 'Icon Buttons'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
                IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Cards
            _buildSectionTitle(context, 'Cards'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 200,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Elevated Card', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text('This is an elevated card with some content.', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Card.filled(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Filled Card', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text('This is a filled card with some content.', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Outlined Card', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text('This is an outlined card with some content.', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Text Fields
            _buildSectionTitle(context, 'Text Fields'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Outlined TextField',
                      hintText: 'Enter text',
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Filled TextField',
                      hintText: 'Enter text',
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Chips
            _buildSectionTitle(context, 'Chips'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: const Text('Basic Chip'),
                  onDeleted: () {},
                ),
                const FilterChip(
                  label: Text('Filter Chip'),
                  selected: true,
                  onSelected: null,
                ),
                ActionChip(
                  label: const Text('Action Chip'),
                  onPressed: () {},
                ),
                InputChip(
                  label: const Text('Input Chip'),
                  onDeleted: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Progress Indicators
            _buildSectionTitle(context, 'Progress Indicators'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Switches and Checkboxes
            _buildSectionTitle(context, 'Selection Controls'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // Remplacer les contrôles liés au thème par des exemples génériques
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Radio<int>(
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}