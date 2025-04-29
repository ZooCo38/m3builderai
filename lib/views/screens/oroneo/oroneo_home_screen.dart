import 'package:flutter/material.dart';

class OroneoHomeScreen extends StatelessWidget {
  final VoidCallback onChatStart;

  const OroneoHomeScreen({
    super.key, 
    required this.onChatStart
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/oroneo/images/logo.png',
          height: 30,
          errorBuilder: (context, error, stackTrace) {
            return const Text('ORONEO');
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.onPrimary,
                    radius: 30,
                    child: Text(
                      'TD',
                      style: TextStyle(
                        fontSize: 24,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Thomas Dupont',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'thomas.dupont@example.com',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Compte client'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historique des conversations'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Aide'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Message de bienvenue
              Text(
                'Bonjour, Thomas !',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Que souhaitez-vous faire aujourd\'hui ?',
                style: theme.textTheme.bodyLarge,
              ),
              
              const SizedBox(height: 24),
              
              // Zone de chat avec l'IA
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: theme.colorScheme.primary,
                          child: Icon(
                            Icons.smart_toy,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Assistant Oroneo',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Quel est votre projet ?',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    
                    // Input de texte
                    InkWell(
                      onTap: onChatStart,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Posez votre question...',
                                style: TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.mic,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.send,
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Suggestions rapides (chips)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          label: const Text('Je veux simuler ma retraite'),
                          onPressed: onChatStart,
                          avatar: const Icon(Icons.calculate, size: 16),
                        ),
                        ActionChip(
                          label: const Text('Je veux défiscaliser'),
                          onPressed: onChatStart,
                          avatar: const Icon(Icons.savings, size: 16),
                        ),
                        ActionChip(
                          label: const Text('J\'ai un projet à financer'),
                          onPressed: onChatStart,
                          avatar: const Icon(Icons.account_balance, size: 16),
                        ),
                        ActionChip(
                          label: const Text('Je protège ma famille'),
                          onPressed: onChatStart,
                          avatar: const Icon(Icons.family_restroom, size: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Titre de la section services
              Text(
                'Nos services',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Cartes de services
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: [
                  _buildServiceCard(
                    context,
                    'Simulateur retraite',
                    'Estimez votre pension et planifiez votre avenir',
                    Icons.calculate,
                    theme.colorScheme.primaryContainer,
                    theme.colorScheme.onPrimaryContainer,
                    onChatStart,
                  ),
                  _buildServiceCard(
                    context,
                    'J\'épargne et je défiscalise',
                    'Optimisez votre fiscalité et votre épargne',
                    Icons.savings,
                    theme.colorScheme.secondaryContainer,
                    theme.colorScheme.onSecondaryContainer,
                    onChatStart,
                  ),
                  _buildServiceCard(
                    context,
                    'Je prépare mon futur',
                    'Investissez pour vos projets de vie',
                    Icons.trending_up,
                    theme.colorScheme.tertiaryContainer,
                    theme.colorScheme.onTertiaryContainer,
                    onChatStart,
                  ),
                  _buildServiceCard(
                    context,
                    'Je protège mes proches',
                    'Solutions d\'assurance pour votre famille',
                    Icons.shield,
                    theme.colorScheme.errorContainer,
                    theme.colorScheme.onErrorContainer,
                    onChatStart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color backgroundColor,
    Color foregroundColor,
    VoidCallback onTap,
  ) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: backgroundColor,
              child: Icon(
                icon,
                size: 40,
                color: foregroundColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}