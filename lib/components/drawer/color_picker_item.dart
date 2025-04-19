import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerItem extends StatelessWidget {
  final String colorName;
  final Color currentColor;
  final Function(Color) onColorChanged;

  const ColorPickerItem({
    super.key,
    required this.colorName,
    required this.currentColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () => _showColorPicker(context),
        child: CircleAvatar(
          backgroundColor: currentColor,
        ),
      ),
      title: Text(colorName),
      trailing: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '#${currentColor.value.toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
      onTap: () => _showColorPicker(context),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color pickerColor = currentColor;
        
        return AlertDialog(
          title: Text('Choisir une couleur pour $colorName'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Appliquer'),
              onPressed: () {
                onColorChanged(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}