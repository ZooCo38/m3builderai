import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_controller.dart';

class AdditionalComponents extends StatelessWidget {
  final Function selectableComponent;

  const AdditionalComponents({
    super.key,
    required this.selectableComponent,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.start,
        children: [
          // Badges
          selectableComponent(
            Badge(
              label: const Text("Badge"),
              child: const Icon(Icons.notifications, size: 30),
            ),
            'Badge',
            ['error', 'onError'],
            description: 'Utilise error pour le fond et onError pour le texte',
            hoverColorProperties: ['error', 'onError'],
            pressedColorProperties: ['error', 'onError', 'surface'],
          ),
          
          // BottomNavigationBar
          selectableComponent(
            SizedBox(
              width: 180,
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                ],
                selectedItemColor: currentTheme.colorScheme.primary,
                unselectedItemColor: currentTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            'BottomNavigationBar',
            ['primary', 'onSurfaceVariant', 'surface'],
            description: 'Utilise primary pour l\'élément sélectionné',
            hoverColorProperties: ['primary', 'onSurfaceVariant', 'surface'],
            pressedColorProperties: ['primary', 'onSurfaceVariant', 'surface', 'surfaceVariant'],
          ),
          
          // FloatingActionButton
          selectableComponent(
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            'FloatingActionButton',
            ['primary', 'onPrimary', 'elevation'],
            description: 'Utilise primary pour le fond et onPrimary pour l\'icône',
            hoverColorProperties: ['primary', 'onPrimary', 'elevation', 'shadow'],
            pressedColorProperties: ['primary', 'onPrimary', 'elevation', 'shadow'],
          ),
          
          // Switch
          selectableComponent(
            Switch(
              value: true,
              onChanged: (_) {},
            ),
            'Switch',
            ['primary', 'surfaceVariant', 'onSurface'],
            description: 'Utilise primary pour l\'état actif',
            hoverColorProperties: ['primary', 'surfaceVariant', 'onSurface'],
            pressedColorProperties: ['primary', 'surfaceVariant', 'onSurface', 'surface'],
          ),
          
          // Checkbox
          selectableComponent(
            Checkbox(
              value: true,
              onChanged: (_) {},
            ),
            'Checkbox',
            ['primary', 'onSurface'],
            description: 'Utilise primary pour l\'état coché',
            hoverColorProperties: ['primary', 'onSurface', 'surfaceVariant'],
            pressedColorProperties: ['primary', 'onSurface', 'surfaceVariant'],
          ),
          
          // Radio
          selectableComponent(
            Radio(
              value: true,
              groupValue: true,
              onChanged: (_) {},
            ),
            'Radio',
            ['primary', 'onSurface'],
            description: 'Utilise primary pour l\'état sélectionné',
            hoverColorProperties: ['primary', 'onSurface', 'surfaceVariant'],
            pressedColorProperties: ['primary', 'onSurface', 'surfaceVariant'],
          ),
          
          // Slider
          selectableComponent(
            SizedBox(
              width: 180,
              child: Slider(
                value: 0.5,
                onChanged: (_) {},
              ),
            ),
            'Slider',
            ['primary', 'surfaceVariant', 'onSurface'],
            description: 'Utilise primary pour le curseur et la partie active',
            hoverColorProperties: ['primary', 'surfaceVariant', 'onSurface'],
            pressedColorProperties: ['primary', 'surfaceVariant', 'onSurface', 'surface'],
          ),
          
          // ProgressIndicator
          selectableComponent(
            SizedBox(
              width: 180,
              child: LinearProgressIndicator(
                value: 0.7,
                backgroundColor: currentTheme.colorScheme.surfaceVariant,
                color: currentTheme.colorScheme.primary,
              ),
            ),
            'ProgressIndicator',
            ['primary', 'surfaceVariant'],
            description: 'Utilise primary pour la progression et surfaceVariant pour l\'arrière-plan',
            hoverColorProperties: ['primary', 'surfaceVariant'],
            pressedColorProperties: ['primary', 'surfaceVariant'],
          ),
          
          // SnackBar (représentation)
          selectableComponent(
            Container(
              width: 180,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: currentTheme.colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Snackbar message',
                style: TextStyle(color: currentTheme.colorScheme.onInverseSurface),
              ),
            ),
            'SnackBar',
            ['inverseSurface', 'onInverseSurface', 'primary'],
            description: 'Utilise inverseSurface pour le fond et onInverseSurface pour le texte',
            hoverColorProperties: ['inverseSurface', 'onInverseSurface', 'primary'],
            pressedColorProperties: ['inverseSurface', 'onInverseSurface', 'primary'],
          ),
          
          // Tooltip (représentation)
          selectableComponent(
            Tooltip(
              message: 'Tooltip',
              child: const Icon(Icons.info),
              decoration: BoxDecoration(
                color: currentTheme.colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(4),
              ),
              textStyle: TextStyle(color: currentTheme.colorScheme.onInverseSurface),
            ),
            'Tooltip',
            ['inverseSurface', 'onInverseSurface'],
            description: 'Utilise inverseSurface pour le fond et onInverseSurface pour le texte',
            hoverColorProperties: ['inverseSurface', 'onInverseSurface'],
            pressedColorProperties: ['inverseSurface', 'onInverseSurface'],
          ),
        ],
      ),
    );
  }
}