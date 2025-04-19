import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/theme_controller.dart';

class HexColorField extends StatefulWidget {
  final String colorName;
  final Color color;
  final ThemeController controller;
  final VoidCallback? onColorChanged;

  const HexColorField({
    Key? key,
    required this.colorName,
    required this.color,
    required this.controller,
    this.onColorChanged,
  }) : super(key: key);

  @override
  State<HexColorField> createState() => _HexColorFieldState();
}

class _HexColorFieldState extends State<HexColorField> {
  late TextEditingController _textController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: _colorToHex(widget.color),
    );
  }

  @override
  void didUpdateWidget(HexColorField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color && !_isEditing) {
      _textController.text = _colorToHex(widget.color);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  }

  Color _hexToColor(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  bool _isValidHex(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }
    return RegExp(r'^([0-9A-Fa-f]{6})$').hasMatch(hex);
  }

  void _applyColor() {
    if (_isValidHex(_textController.text)) {
      final color = _hexToColor(_textController.text);
      widget.controller.updateThemeColor(widget.colorName, color);
      if (widget.onColorChanged != null) {
        widget.onColorChanged!();
      }
    } else {
      // Réinitialiser à la couleur actuelle si le format est invalide
      _textController.text = _colorToHex(widget.color);
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
        // Focus sur le champ de texte
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: _isEditing
            ? TextField(
                controller: _textController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  fontSize: 14,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F#]')),
                  LengthLimitingTextInputFormatter(7),
                ],
                autofocus: true,
                onSubmitted: (_) => _applyColor(),
                onEditingComplete: _applyColor,
              )
            : Text(
                _colorToHex(widget.color),
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}