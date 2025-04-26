import 'package:flutter/material.dart';
import '../../theme/theme_controller.dart';

class SelectedComponentSection extends StatelessWidget {
  final ThemeController themeController;
  final Future<Color?> Function(BuildContext, Color) showColorPicker;
  final Future<String?> Function(BuildContext, String) showHexEditDialog;

  const SelectedComponentSection({
    super.key,
    required this.themeController,
    required this.showColorPicker,
    required this.showHexEditDialog,
  });

  @override
  Widget build(BuildContext context) {
    final componentInfo = themeController.selectedComponentInfo;
    if (componentInfo == null) return const SizedBox.shrink();

    // Filtrer pour n'obtenir que les couleurs de base (sans les états hover/pressed)
    final baseColors = componentInfo.usedColorProperties.where((color) => 
      !color.contains('hover') && !color.contains('pressed')).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Composant sélectionné:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            componentInfo.componentName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Afficher les couleurs de base utilisées par ce composant
          if (baseColors.isNotEmpty) ...[
            Text(
              'Couleurs utilisées:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            
            // Afficher les couleurs de base sous forme de liste
            ...baseColors.map((colorName) {
              final color = themeController.getCurrentColor(colorName);
              return _buildColorTile(context, colorName, color);
            }).toList(),
            
            // Ajouter un message concernant shadow si nécessaire
            if (componentInfo.componentName.contains('Button') && 
                !baseColors.any((color) => color.contains('shadow'))) ...[
              const SizedBox(height: 8),
              Text(
                'Note: L\'ombre du bouton est gérée automatiquement par le système de thème.',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
  
  Widget _buildColorTile(BuildContext context, String colorName, Color color) {
    // Convertir la couleur en format HEX
    String hexColor = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () async {
          // Utiliser l'éditeur HEX au lieu du color picker
          final String? newHexColor = await showHexEditDialog(context, hexColor);
          if (newHexColor != null) {
            // Convertir le code HEX en Color
            final Color newColor = Color(int.parse(newHexColor.substring(1), radix: 16) | 0xFF000000);
            themeController.updateThemeColor(colorName, newColor);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      colorName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      hexColor.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}