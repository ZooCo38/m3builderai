import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        // App Bar
        Container(
          height: 56,
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back),
              Text(
                'Profil',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Icon(Icons.edit),
            ],
          ),
        ),
        
        // Profile content
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Header avec photo de profil
              Container(
                color: colorScheme.primaryContainer,
                padding: const EdgeInsets.only(top: 32, bottom: 24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.primary,
                      child: Text(
                        'JD',
                        style: TextStyle(
                          fontSize: 32,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@example.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Statistiques
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn(context, 'Posts', '24'),
                    _buildStatColumn(context, 'Followers', '482'),
                    _buildStatColumn(context, 'Following', '128'),
                  ],
                ),
              ),
              
              const Divider(),
              
              // Sections
              ListTile(
                leading: Icon(Icons.settings, color: colorScheme.primary),
                title: const Text('Paramètres'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: colorScheme.primary),
                title: const Text('Confidentialité'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.help, color: colorScheme.primary),
                title: const Text('Aide et support'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.logout, color: colorScheme.primary),
                title: const Text('Déconnexion'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatColumn(BuildContext context, String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}