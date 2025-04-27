import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_controller.dart';

class WebPreview extends StatefulWidget {
  const WebPreview({Key? key}) : super(key: key);

  @override
  State<WebPreview> createState() => _WebPreviewState();
}

class _WebPreviewState extends State<WebPreview> {
  String _currentUrl = 'material.io';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    
    return Scaffold(
      backgroundColor: currentTheme.colorScheme.background,
      body: Column(
        children: [
          // Barre d'adresse du navigateur
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: currentTheme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Boutons de navigation
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                  tooltip: 'Retour',
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {},
                  tooltip: 'Suivant',
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    Future.delayed(const Duration(milliseconds: 800), () {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    });
                  },
                  tooltip: 'Actualiser',
                ),
                
                // Barre d'adresse
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: currentTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: currentTheme.colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 16,
                          color: currentTheme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _currentUrl,
                          style: TextStyle(
                            color: currentTheme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Boutons supplémentaires
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                  tooltip: 'Favoris',
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                  tooltip: 'Plus',
                ),
              ],
            ),
          ),
          
          // Contenu principal
          Expanded(
            child: _isLoading 
                ? Center(
                    child: CircularProgressIndicator(
                      color: currentTheme.colorScheme.primary,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // En-tête Material Design
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          color: currentTheme.colorScheme.primary,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: currentTheme.colorScheme.onPrimary,
                                    radius: 20,
                                    child: Icon(
                                      Icons.design_services,
                                      color: currentTheme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Material 3 Builder',
                                    style: TextStyle(
                                      color: currentTheme.colorScheme.onPrimary,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Explorez les composants Material 3',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onPrimary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Découvrez comment utiliser les composants Material 3 dans vos applications Flutter.',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onPrimary.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: currentTheme.colorScheme.onPrimary,
                                  foregroundColor: currentTheme.colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                ),
                                child: const Text('Commencer'),
                              ),
                            ],
                          ),
                        ),
                        
                        // Section des composants
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Composants',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onBackground,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // Grille de composants
                              // Dans la méthode build, remplacer la GridView.count par :
                              GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 24,
                                crossAxisSpacing: 24,
                                childAspectRatio: 0.8, // Ajuster le ratio pour donner plus de hauteur
                                children: [
                                  _buildComponentCard(
                                    context,
                                    'Boutons',
                                    Icons.touch_app,
                                    currentTheme,
                                  ),
                                  _buildComponentCard(
                                    context,
                                    'Cartes',
                                    Icons.crop_square,
                                    currentTheme,
                                  ),
                                  _buildComponentCard(
                                    context,
                                    'Champs de texte',
                                    Icons.text_fields,
                                    currentTheme,
                                  ),
                                  _buildComponentCard(
                                    context,
                                    'Dialogues',
                                    Icons.chat_bubble_outline,
                                    currentTheme,
                                  ),
                                  _buildComponentCard(
                                    context,
                                    'Navigation',
                                    Icons.menu,
                                    currentTheme,
                                  ),
                                  _buildComponentCard(
                                    context,
                                    'Sélection',
                                    Icons.check_circle_outline,
                                    currentTheme,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Section des thèmes
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          color: currentTheme.colorScheme.surfaceVariant,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thèmes',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onSurfaceVariant,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Personnalisez l\'apparence de votre application avec Material 3.',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onSurfaceVariant,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // Palette de couleurs
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildColorCircle(currentTheme.colorScheme.primary, 'Primary'),
                                  _buildColorCircle(currentTheme.colorScheme.secondary, 'Secondary'),
                                  _buildColorCircle(currentTheme.colorScheme.tertiary, 'Tertiary'),
                                  _buildColorCircle(currentTheme.colorScheme.error, 'Error'),
                                  _buildColorCircle(currentTheme.colorScheme.surface, 'Surface'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Pied de page
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          color: currentTheme.colorScheme.surfaceContainerHighest,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '© 2023 Material 3 Builder',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Créé avec Flutter et Material 3',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildComponentCard(BuildContext context, String title, IconData icon, ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Titre du composant
              Text(
                title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Exemples de composants
              Expanded(
                child: _buildComponentExamples(title, theme),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Nouvelle méthode pour construire les exemples de composants
  Widget _buildComponentExamples(String componentType, ThemeData theme) {
    switch (componentType) {
      case 'Boutons':
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated'),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('Filled'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Text'),
            ),
          ],
        );
        
      case 'Cartes':
        return Center(
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Carte exemple',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contenu de la carte',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        
      case 'Champs de texte':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Standard',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Filled',
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
        
      case 'Dialogues':
        return Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Titre du dialogue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contenu du dialogue avec des informations',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        
      case 'Navigation':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Barre de navigation
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: theme.colorScheme.primary),
                  Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
                  Icon(Icons.favorite, color: theme.colorScheme.onSurfaceVariant),
                  Icon(Icons.person, color: theme.colorScheme.onSurfaceVariant),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Drawer miniature
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    color: theme.colorScheme.surfaceVariant,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          height: 2,
                          width: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 2,
                          width: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 2,
                          width: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        
      case 'Sélection':
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Text(
                  'Checkbox',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            // Radio
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                ),
                Text(
                  'Radio',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            // Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
                Text(
                  'Switch',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        );
        
      default:
        return Center(
          child: Icon(
            _getIconForComponentType(componentType),
            size: 48,
            color: theme.colorScheme.primary,
          ),
        );
    }
  }
  
  // Méthode pour obtenir l'icône correspondant au type de composant
  IconData _getIconForComponentType(String componentType) {
    switch (componentType) {
      case 'Boutons':
        return Icons.touch_app;
      case 'Cartes':
        return Icons.crop_square;
      case 'Champs de texte':
        return Icons.text_fields;
      case 'Dialogues':
        return Icons.chat_bubble_outline;
      case 'Navigation':
        return Icons.menu;
      case 'Sélection':
        return Icons.check_circle_outline;
      default:
        return Icons.widgets;
    }
  }
  Widget _buildColorCircle(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}