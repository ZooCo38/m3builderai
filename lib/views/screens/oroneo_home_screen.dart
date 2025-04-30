import 'package:flutter/material.dart';
import '../../widgets/oroneo_logo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OroneoHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  OroneoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorScheme.surface, // Ajout de la couleur de fond
        leading: IconButton(
          icon: _buildSvgIcon(
            'menu',
            color: colorScheme.onSurface, // Couleur adaptative pour l'icône
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const OroneoLogo(size: 20, useFullLogo: true),
        actions: [
          IconButton(
            icon: _buildSvgIcon(
              'notifications',
              color: colorScheme.onSurface, // Couleur adaptative pour l'icône
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: _buildSvgIcon('chat_rounded'),
              title: const Text('Messages'),
            ),
            ListTile(
              leading: _buildSvgIcon('account_balance'),
              title: const Text('PER'),
            ),
            ListTile(
              leading: _buildSvgIcon('shield_rounded'),
              title: const Text('Assurance vie'),
            ),
            const Divider(),
            ListTile(
              leading: _buildSvgIcon('history_rounded'),
              title: const Text('Historique des conversations'),
            ),
            const Divider(),
            ListTile(
              leading: _buildSvgIcon('logout_rounded'),
              title: const Text('Déconnexion'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Message de bienvenue personnalisé
          Text(
            '☀️ Bonjour John Doe !',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Comment puis-je vous aider aujourd\'hui ?',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          
          // Bloc d'entrée en relation avec l'IA
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Un projet où je pourrais vous aider ?',
                      filled: true,
                      fillColor: colorScheme.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // Harmonisation avec les chips
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: _buildSvgIcon('mic'),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: _buildSvgIcon('send'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 140, // Largeur fixe pour tous les chips
                              child: _buildActionChip(context, 'Retraite', 'analytics'),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 140, // Largeur fixe pour tous les chips
                              child: _buildActionChip(context, 'Protection', 'shield'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 140, // Largeur fixe pour tous les chips
                              child: _buildActionChip(context, 'Défiscaliser', 'savings'),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 140, // Largeur fixe pour tous les chips
                              child: _buildActionChip(context, 'Projet', 'euro'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Services
          _buildServiceCard(
            context,
            'Simulateur retraite',
            'Estimez votre pension et optimisez votre épargne',
            'analytics',
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            context,
            'J\'épargne, je défiscalise',
            'Solutions pour réduire vos impôts tout en épargnant',
            'savings',
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            context,
            'Je prépare mon futur aujourd\'hui',
            'Planification financière à long terme',
            'trending_up',
          ),
        ],
      ),
      // Extended FAB centré en bas
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Nouvelle conversation'),
          icon: _buildSvgIcon(
            'add',
            color: colorScheme.onPrimaryContainer, // Utilisation de onPrimaryContainer
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildActionChip(BuildContext context, String label, String iconName) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 140,
      child: ActionChip(
        avatar: SizedBox(
          width: 18,
          height: 18,
          child: _buildSvgIcon(
            iconName,
            size: 16,
            color: colorScheme.primary,
          ),
        ),
        label: Container(
          width: double.infinity,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: colorScheme.surfaceVariant,
        side: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
        onPressed: () {},
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String description, String iconName) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: SizedBox(
          width: 32,
          height: 32,
          child: _buildSvgIcon(
            iconName,
            size: 32,
            color: theme.textTheme.titleMedium?.color, // Utilisation de la couleur du texte
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: colorScheme.primary),
        onTap: () {},
      ),
    );
  }
  Widget _buildSvgIcon(String assetName, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/oroneo/icons/$assetName.svg',
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }
}