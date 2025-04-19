// Correction de la première ligne qui contient "flutter" par erreur
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Ajouter cet import
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../utils/platform_helper.dart';
import '../../theme/theme_controller.dart';
import '../../theme/theme_import.dart';
import '../../theme/theme_export.dart';

class ThemeEditorDrawer extends StatefulWidget {
  const ThemeEditorDrawer({super.key});

  @override
  State<ThemeEditorDrawer> createState() => _ThemeEditorDrawerState();
}

class _ThemeEditorDrawerState extends State<ThemeEditorDrawer> {
  bool _isUploading = false;
  bool _isExporting = false;
  String _exportFormat = 'dart';
  
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    
    // Déboguer les couleurs
    final isDark = themeController.themeMode == ThemeMode.dark;
    final surfaceColor = isDark 
        ? Theme.of(context).colorScheme.surface  // Utiliser directement le thème
        : themeController.getCurrentColor('surface');
    
    print("ThemeEditorDrawer - Mode: ${isDark ? 'Dark' : 'Light'}");
    print("ThemeEditorDrawer - Surface from Theme: ${Theme.of(context).colorScheme.surface}");
    print("ThemeEditorDrawer - Surface from Controller: ${themeController.getCurrentColor('surface')}");
    
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
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: themeController.getCurrentColor('primaryContainer'),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.palette,
                  color: themeController.getCurrentColor('onPrimaryContainer'),
                ),
                const SizedBox(width: 8),
                Text(
                  'Theme Editor',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: themeController.getCurrentColor('onPrimaryContainer'),
                  ),
                ),
                const Spacer(),
                // Boutons d'import/export
                IconButton(
                  icon: _isUploading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.upload_file),
                  onPressed: _isUploading ? null : _uploadTheme,
                  tooltip: 'Import Theme',
                ),
                PopupMenuButton<String>(
                  icon: _isExporting
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.download),
                  tooltip: 'Export Theme',
                  onSelected: (format) {
                    setState(() {
                      _exportFormat = format;
                    });
                    _exportTheme(format);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'dart',
                      child: Text('Export as Dart'),
                    ),
                    const PopupMenuItem(
                      value: 'xml',
                      child: Text('Export as XML'),
                    ),
                    const PopupMenuItem(
                      value: 'css',
                      child: Text('Export as CSS'),
                    ),
                    const PopupMenuItem(
                      value: 'json',
                      child: Text('Export as JSON'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Liste des couleurs du thème
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
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
  // Remplacer la méthode _uploadTheme
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
    }  // Ajout de l'accolade fermante manquante ici
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
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: InkWell(
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
}

// Widget pour le sélecteur de couleur
class ColorPicker extends StatefulWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final double pickerAreaHeightPercent;

  const ColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
    this.pickerAreaHeightPercent = 1.0,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _currentColor;
  late TextEditingController _hexController;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.pickerColor;
    _hexController = TextEditingController(
      text: '#${_currentColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
    );
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  void _updateColor(Color color) {
    setState(() {
      _currentColor = color;
      _hexController.text = '#${_currentColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    });
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Affichage de la couleur sélectionnée
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: _currentColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        
        // Sliders pour les composantes RGB
        _buildColorSlider(
          label: 'R',
          value: _currentColor.red.toDouble(),
          color: Colors.red,
          onChanged: (value) {
            _updateColor(Color.fromARGB(
              _currentColor.alpha,
              value.toInt(),
              _currentColor.green,
              _currentColor.blue,
            ));
          },
        ),
        _buildColorSlider(
          label: 'G',
          value: _currentColor.green.toDouble(),
          color: Colors.green,
          onChanged: (value) {
            _updateColor(Color.fromARGB(
              _currentColor.alpha,
              _currentColor.red,
              value.toInt(),
              _currentColor.blue,
            ));
          },
        ),
        _buildColorSlider(
          label: 'B',
          value: _currentColor.blue.toDouble(),
          color: Colors.blue,
          onChanged: (value) {
            _updateColor(Color.fromARGB(
              _currentColor.alpha,
              _currentColor.red,
              _currentColor.green,
              value.toInt(),
            ));
          },
        ),
        _buildColorSlider(
          label: 'A',
          value: _currentColor.alpha.toDouble(),
          color: Colors.grey,
          onChanged: (value) {
            _updateColor(Color.fromARGB(
              value.toInt(),
              _currentColor.red,
              _currentColor.green,
              _currentColor.blue,
            ));
          },
        ),
        
        // Champ de texte pour la valeur hexadécimale
        TextField(
          controller: _hexController,
          decoration: const InputDecoration(
            labelText: 'Hex Color',
            hintText: '#AARRGGBB',
          ),
          onSubmitted: (value) {
            try {
              if (value.startsWith('#')) {
                value = value.substring(1);
              }
              if (value.length == 6) {
                value = 'FF$value'; // Ajouter l'opacité si elle n'est pas présente
              }
              final color = Color(int.parse(value, radix: 16));
              _updateColor(color);
            } catch (e) {
              // Ignorer les erreurs de parsing
            }
          },
        ),
      ],
    );
  }

  Widget _buildColorSlider({
    required String label,
    required double value,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(label),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            divisions: 255,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(value.toInt().toString()),
        ),
      ],
    );
  }
}