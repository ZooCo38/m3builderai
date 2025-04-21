import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:provider/provider.dart';
import '../theme/theme_controller.dart';

class FlexThemeSettings extends StatelessWidget {
  const FlexThemeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre
            Text(
              'Paramètres FlexColorScheme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Switch pour activer/désactiver FlexColorScheme
            SwitchListTile(
              title: const Text('Utiliser FlexColorScheme'),
              value: themeController.useFlexColorScheme,
              onChanged: (value) {
                themeController.setUseFlexColorScheme(value);
              },
            ),
            
            if (themeController.useFlexColorScheme) ...[
              const SizedBox(height: 16),
              
              // Sélecteur de schéma
              DropdownButton<FlexScheme>(
                isExpanded: true,
                value: themeController.flexScheme,
                onChanged: (FlexScheme? newValue) {
                  if (newValue != null) {
                    themeController.setFlexScheme(newValue);
                  }
                },
                items: FlexScheme.values.map((FlexScheme scheme) {
                  return DropdownMenuItem<FlexScheme>(
                    value: scheme,
                    child: Text(scheme.toString().split('.').last),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 16),
              
              // Slider pour le niveau de mélange
              Text('Niveau de mélange: ${themeController.blendLevel.toInt()}'),
              Slider(
                value: themeController.blendLevel,
                min: 0,
                max: 40,
                divisions: 40,
                label: themeController.blendLevel.toInt().toString(),
                onChanged: (double value) {
                  themeController.setBlendLevel(value);
                },
              ),
              
              // Switch pour Material 3
              SwitchListTile(
                title: const Text('Utiliser Material 3'),
                value: themeController.useMaterial3,
                onChanged: (value) {
                  themeController.setUseMaterial3(value);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}