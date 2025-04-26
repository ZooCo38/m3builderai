import 'package:flutter/material.dart';

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