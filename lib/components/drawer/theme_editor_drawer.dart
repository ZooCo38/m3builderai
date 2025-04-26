// Correction de la première ligne qui contient "flutter" par erreur
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../utils/platform_helper.dart';
import '../../theme/theme_controller.dart';
import '../../theme/theme_import.dart';
import '../../theme/theme_export.dart';
import 'color_picker.dart';
import 'selected_component_section.dart';

class ThemeEditorDrawer extends StatefulWidget {
  const ThemeEditorDrawer({super.key});

  @override
  State<ThemeEditorDrawer> createState() => _ThemeEditorDrawerState();
}

class _ThemeEditorDrawerState extends State<ThemeEditorDrawer> {
  bool _isUploading = false;
  bool _isExporting = false;
  String _exportFormat = 'dart';
  
  // Dans la méthode build de _ThemeEditorDrawerState
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    
    // Déboguer les couleurs
    final isDark = themeController.themeMode == ThemeMode.dark;
    final surfaceColor = isDark 
        ? Theme.of(context).colorScheme.surface  // Utiliser directement le thème
        : themeController.getCurrentColor('surface');
    
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: surfaceColor, // Utiliser la couleur de surface du thème actuel
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Column(
        children: [
          // En-tête du drawer
          _buildHeader(themeController),
          
          // Contenu principal
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Afficher la section du composant sélectionné si un composant est sélectionné
                if (themeController.selectedComponentInfo != null)
                  SelectedComponentSection(
                    themeController: themeController,
                    showColorPicker: showColorPicker,
                    showHexEditDialog: _showHexEditDialog, // Ajouter cette ligne
                  ),
                
                // Liste des couleurs du thème
                _buildColorSection(
                  'Primary',
                  [
                    _buildColorTile('primary', 'Primary', themeController),
                    _buildColorTile('onPrimary', 'On Primary', themeController),
                    _buildColorTile('primaryContainer', 'Primary Container', themeController),
                    _buildColorTile('onPrimaryContainer', 'On Primary Container', themeController),
                  ],
                ),
                _buildColorSection(
                  'Secondary',
                  [
                    _buildColorTile('secondary', 'Secondary', themeController),
                    _buildColorTile('onSecondary', 'On Secondary', themeController),
                    _buildColorTile('secondaryContainer', 'Secondary Container', themeController),
                    _buildColorTile('onSecondaryContainer', 'On Secondary Container', themeController),
                  ],
                ),
                _buildColorSection(
                  'Tertiary',
                  [
                    _buildColorTile('tertiary', 'Tertiary', themeController),
                    _buildColorTile('onTertiary', 'On Tertiary', themeController),
                    _buildColorTile('tertiaryContainer', 'Tertiary Container', themeController),
                    _buildColorTile('onTertiaryContainer', 'On Tertiary Container', themeController),
                  ],
                ),
                _buildColorSection(
                  'Error',
                  [
                    _buildColorTile('error', 'Error', themeController),
                    _buildColorTile('onError', 'On Error', themeController),
                    _buildColorTile('errorContainer', 'Error Container', themeController),
                    _buildColorTile('onErrorContainer', 'On Error Container', themeController),
                  ],
                ),
                _buildColorSection(
                  'Background',
                  [
                    _buildColorTile('background', 'Background', themeController),
                    _buildColorTile('onBackground', 'On Background', themeController),
                  ],
                ),
                _buildColorSection(
                  'Surface',
                  [
                    _buildColorTile('surface', 'Surface', themeController),
                    _buildColorTile('onSurface', 'On Surface', themeController),
                    _buildColorTile('surfaceVariant', 'Surface Variant', themeController),
                    _buildColorTile('onSurfaceVariant', 'On Surface Variant', themeController),
                  ],
                ),
                // Nouvelles sections pour les couleurs supplémentaires de Material 3
                _buildColorSection(
                  'Surface Containers',
                  [
                    _buildColorTile('surfaceContainer', 'Surface Container', themeController),
                    _buildColorTile('surfaceContainerLow', 'Surface Container Low', themeController),
                    _buildColorTile('surfaceContainerHigh', 'Surface Container High', themeController),
                    _buildColorTile('surfaceContainerHighest', 'Surface Container Highest', themeController),
                    _buildColorTile('surfaceBright', 'Surface Bright', themeController),
                    _buildColorTile('surfaceDim', 'Surface Dim', themeController),
                  ],
                ),
                _buildColorSection(
                  'Outline',
                  [
                    _buildColorTile('outline', 'Outline', themeController),
                    _buildColorTile('outlineVariant', 'Outline Variant', themeController),
                  ],
                ),
                _buildColorSection(
                  'Elevation',
                  [
                    _buildColorTile('elevation', 'Elevation', themeController),
                  ],
                ),
                _buildColorSection(
                  'Shadow',
                  [
                    _buildColorTile('shadow', 'Shadow', themeController),
                    _buildColorTile('scrim', 'Scrim', themeController),
                  ],
                ),
                _buildColorSection(
                  'Inverse',
                  [
                    _buildColorTile('inverseSurface', 'Inverse Surface', themeController),
                    _buildColorTile('onInverseSurface', 'On Inverse Surface', themeController),
                    _buildColorTile('inversePrimary', 'Inverse Primary', themeController),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour gérer l'upload du thème
  Future<void> _uploadTheme() async {
    setState(() {
      _isUploading = true;
    });
  
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'dart', 'xml', 'css'],
        withData: true, // Important pour le web
      );
  
      if (result != null) {
        String? content;
        String extension = result.files.single.extension?.toLowerCase() ?? '';
        
        // Utiliser les bytes du fichier qui fonctionnent sur toutes les plateformes
        final bytes = result.files.single.bytes;
        if (bytes != null) {
          content = utf8.decode(bytes);
          
          if (content != null) {
            final themeController = Provider.of<ThemeController>(context, listen: false);
            bool success = await ThemeImporter.importTheme(
              content, 
              extension, 
              themeController
            );
            
            if (success) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Theme imported successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error importing theme'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          }
        } else {
          throw Exception('Failed to read file');
        }
      }
    } catch (e) {
      print('Error during theme import: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  // Méthode pour gérer l'export du thème
  Future<void> _exportTheme(String format) async {
    setState(() {
      _isExporting = true;
    });

    try {
      final themeController = Provider.of<ThemeController>(context, listen: false);
      final brightness = Theme.of(context).brightness;
      
      final content = await ThemeExporter.exportTheme(
        themeController.currentThemeModel,
        format,
        brightness,
        darkThemeModel: themeController.darkThemeModel,
        lightMediumModel: themeController.lightMediumContrastModel,
        lightHighModel: themeController.lightHighContrastModel,
        darkMediumModel: themeController.darkMediumContrastModel,
        darkHighModel: themeController.darkHighContrastModel,
      );
      
      if (content != null) {
        await ThemeExporter.saveExportedTheme(content, format);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Theme exported as $format'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error exporting theme'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      print('Error during theme export: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }

  // Méthode pour construire une section de couleurs
  Widget _buildColorSection(String title, List<Widget> colorTiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ...colorTiles,
        const Divider(),
      ],
    );
  }

  // Méthode pour construire une tuile de couleur
  Widget _buildColorTile(String colorName, String label, ThemeController themeController) {
    // Utiliser getCurrentColor pour obtenir la couleur actuelle en fonction du mode (light/dark)
    Color color = themeController.getCurrentColor(colorName);
    
    // Convertir la couleur en code HEX à 6 caractères (sans l'alpha)
    String hexColor = '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
    
    // Vérifier si cette couleur est utilisée par le composant sélectionné
    bool isHighlighted = false;
    String? componentName;
    if (themeController.selectedComponentInfo != null) {
      isHighlighted = themeController.selectedComponentInfo!.usedColorProperties.contains(colorName);
      componentName = themeController.selectedComponentInfo!.componentName;
    }
    
    return Container(
      decoration: BoxDecoration(
        border: isHighlighted
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
        borderRadius: BorderRadius.circular(8),
        color: isHighlighted ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2) : null,
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(isHighlighted ? 4 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isHighlighted && componentName != null)
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 2),
              child: Text(
                'Utilisé par: $componentName',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(label),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    // Afficher un dialogue pour éditer le code HEX
                    final String? newHexColor = await _showHexEditDialog(context, hexColor);
                    if (newHexColor != null) {
                      try {
                        // Convertir le code HEX en couleur
                        String hex = newHexColor;
                        if (hex.startsWith('#')) {
                          hex = hex.substring(1);
                        }
                        // Ajouter l'alpha (FF) si nécessaire
                        if (hex.length == 6) {
                          hex = 'FF$hex';
                        }
                        final newColor = Color(int.parse(hex, radix: 16));
                        // Mettre à jour la couleur
                        themeController.updateThemeColor(colorName, newColor);
                        // Forcer la mise à jour de l'interface
                        setState(() {});
                      } catch (e) {
                        // Afficher une erreur si le format est invalide
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid HEX color format'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      hexColor,
                      style: const TextStyle(
                        fontFamily: 'Roboto Mono',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (isHighlighted)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Cliquez pour modifier cette couleur',
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            trailing: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
            onTap: () async {
              final Color? newColor = await showColorPicker(context, color);
              if (newColor != null) {
                themeController.updateThemeColor(colorName, newColor);
                // Forcer la mise à jour de l'interface
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  // Nouvelle méthode pour afficher un dialogue d'édition du code HEX
  Future<String?> _showHexEditDialog(BuildContext context, String initialHexColor) async {
    final TextEditingController controller = TextEditingController(text: initialHexColor);
    
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit HEX Color'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'HEX Color',
              hintText: '#RRGGBB',
            ),
            autofocus: true,
            inputFormatters: [
              // Limiter à 7 caractères (# + 6 chiffres hex)
              LengthLimitingTextInputFormatter(7),
              // N'autoriser que les caractères hexadécimaux et #
              FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F#]')),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                // Valider le format
                String hex = controller.text;
                if (hex.startsWith('#')) {
                  hex = hex.substring(1);
                }
                if (RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(hex)) {
                  Navigator.of(context).pop(controller.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid HEX color format'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Méthode pour afficher le sélecteur de couleur
  Future<Color?> showColorPicker(BuildContext context, Color initialColor) async {
    Color selectedColor = initialColor;
    
    return showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: (Color color) {
                selectedColor = color;
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop(selectedColor);
              },
            ),
          ],
        );
      },
    );
  }

  // Méthode pour construire l'en-tête du drawer
  Widget _buildHeader(ThemeController themeController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Réduire le padding vertical
      decoration: BoxDecoration(
        color: themeController.getCurrentColor('primaryContainer'),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max, // S'assurer que la Row prend toute la largeur disponible
        children: [
          Icon(
            Icons.palette,
            color: themeController.getCurrentColor('onPrimaryContainer'),
            size: 20, // Réduire légèrement la taille de l'icône
          ),
          const SizedBox(width: 8),
          Expanded( // Utiliser Expanded pour éviter les débordements du texte
            child: Text(
              'Éditeur de thème',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: themeController.getCurrentColor('onPrimaryContainer'),
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis, // Ajouter une ellipse si le texte est trop long
            ),
          ),
          // Boutons d'import/export
          IconButton(
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40), // Contraintes fixes pour l'IconButton
            iconSize: 20, // Réduire la taille de l'icône
            padding: EdgeInsets.zero, // Supprimer le padding
            icon: _isUploading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    Icons.upload_file,
                    color: themeController.getCurrentColor('onPrimaryContainer'),
                  ),
            onPressed: _isUploading ? null : _uploadTheme,
            tooltip: 'Importer un thème',
          ),
          PopupMenuButton<String>(
            padding: EdgeInsets.zero, // Supprimer le padding
            iconSize: 20, // Réduire la taille de l'icône
            icon: _isExporting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    Icons.download,
                    color: themeController.getCurrentColor('onPrimaryContainer'),
                  ),
            tooltip: 'Exporter le thème',
            onSelected: (format) {
              setState(() {
                _exportFormat = format;
              });
              _exportTheme(format);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'dart',
                child: Text('Exporter en Dart'),
              ),
              const PopupMenuItem(
                value: 'xml',
                child: Text('Exporter en XML'),
              ),
              const PopupMenuItem(
                value: 'css',
                child: Text('Exporter en CSS'),
              ),
              const PopupMenuItem(
                value: 'json',
                child: Text('Exporter en JSON'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}