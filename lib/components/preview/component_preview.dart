import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_controller.dart';
import '../../views/components_view.dart';
import '../../views/mobile_preview.dart';
import '../../views/web_preview.dart';

class ComponentPreview extends StatelessWidget {
  final String viewType;
  
  const ComponentPreview({super.key, required this.viewType});
  
  @override
  Widget build(BuildContext context) {
    // Récupérer le ThemeController pour s'assurer que les changements de thème sont pris en compte
    final themeController = Provider.of<ThemeController>(context);
    
    // Forcer la reconstruction du widget à chaque changement de thème
    print("ComponentPreview rebuilding with theme: ${themeController.themeMode}");
    
    // Sélectionner la vue en fonction du type
    Widget selectedView;
    switch (viewType) {
      case 'Components':
        selectedView = const ComponentsView();
        break;
      case 'Mobile':
        selectedView = const MobilePreview();
        break;
      case 'Web':
        selectedView = const WebPreview();
        break;
      default:
        selectedView = const ComponentsView();
    }
    
    // Utiliser un Theme pour s'assurer que le thème est correctement appliqué
    return Theme(
      // Utiliser le thème personnalisé en fonction du mode actuel
      data: themeController.currentTheme,
      child: Builder(
        builder: (context) {
          // Utiliser un Material avec la transparence
          return Material(
            type: MaterialType.transparency,
            child: selectedView,
          );
        }
      ),
    );
  }
}