import 'package:flutter/material.dart';

class OroneoClientAccountScreen extends StatelessWidget {
  final VoidCallback onBackToHome;

  const OroneoClientAccountScreen({
    Key? key, 
    required this.onBackToHome
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon compte'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackToHome,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête du profil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: theme.colorScheme.primaryContainer,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.colorScheme.onPrimaryContainer,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: theme.colorScheme.primaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Jean Dupont',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'jean.dupont@example.com',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text('Modifier le profil'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onPrimaryContainer,
                      side: BorderSide(color: theme.colorScheme.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
            ),
            
            // Informations personnelles
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations personnelles',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Informations de contact',
                    [
                      {'label': 'Téléphone', 'value': '06 12 34 56 78'},
                      {'label': 'Adresse', 'value': '123 Rue de Paris, 75001 Paris'},
                      {'label': 'Date de naissance', 'value': '15/05/1978'},
                    ],
                    Icons.contact_phone,
                    theme,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Situation professionnelle',
                    [
                      {'label': 'Statut', 'value': 'Salarié'},
                      {'label': 'Entreprise', 'value': 'Entreprise ABC'},
                      {'label': 'Secteur', 'value': 'Finance'},
                    ],
                    Icons.work,
                    theme,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Mes projets
                  Text(
                    'Mes projets',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProjectCard(
                    context,
                    'Préparation retraite',
                    'Simulation et optimisation de votre retraite',
                    '65%',
                    0.65,
                    theme.colorScheme.primary,
                    theme,
                  ),
                  const SizedBox(height: 12),
                  _buildProjectCard(
                    context,
                    'Défiscalisation',
                    'Réduction d\'impôts via investissement',
                    '30%',
                    0.3,
                    theme.colorScheme.tertiary,
                    theme,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Paramètres du compte
                  Text(
                    'Paramètres du compte',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    'Sécurité et confidentialité',
                    'Gérer vos mots de passe et options de sécurité',
                    Icons.security,
                    theme,
                  ),
                  _buildSettingItem(
                    context,
                    'Notifications',
                    'Gérer vos préférences de notifications',
                    Icons.notifications,
                    theme,
                  ),
                  _buildSettingItem(
                    context,
                    'Préférences de communication',
                    'Gérer comment nous communiquons avec vous',
                    Icons.email,
                    theme,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Bouton de déconnexion
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text('Se déconnecter'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                        side: BorderSide(color: theme.colorScheme.error),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Méthode pour construire une carte d'informations
  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Map<String, String>> items,
    IconData icon,
    ThemeData theme,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      item['label']!,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['value']!,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
  
  // Méthode pour construire une carte de projet
  Widget _buildProjectCard(
    BuildContext context,
    String title,
    String description,
    String progressText,
    double progressValue,
    Color progressColor,
    ThemeData theme,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  progressText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // Méthode pour construire un élément de paramètres
  Widget _buildSettingItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    ThemeData theme,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}