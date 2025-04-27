import 'package:flutter/material.dart';

class OroneoClientAccountScreen extends StatelessWidget {
  const OroneoClientAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec informations du client
          Container(
            padding: const EdgeInsets.all(24),
            color: colorScheme.primaryContainer.withOpacity(0.5),
            child: Column(
              children: [
                // Avatar du client
                CircleAvatar(
                  radius: 40,
                  backgroundColor: colorScheme.primary,
                  child: Text(
                    'TD',
                    style: TextStyle(
                      fontSize: 24,
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Nom du client
                Text(
                  'Thomas Dupont',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Email du client
                Text(
                  'thomas.dupont@example.com',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                
                const SizedBox(height: 16),
                
                // Bouton d'édition du profil
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier le profil'),
                ),
              ],
            ),
          ),
          
          // Résumé des contrats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mes contrats',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Carte contrat PER
                _buildContractCard(
                  context,
                  'Plan Épargne Retraite',
                  'PER Individuel',
                  '45 600 €',
                  '+4.2% cette année',
                  Icons.trending_up,
                  colorScheme.primary,
                ),
                
                // Carte contrat Assurance Vie
                _buildContractCard(
                  context,
                  'Assurance Vie',
                  'Multisupport',
                  '78 250 €',
                  '+3.8% cette année',
                  Icons.account_balance_wallet,
                  colorScheme.secondary,
                ),
                
                // Carte contrat Prévoyance
                _buildContractCard(
                  context,
                  'Prévoyance',
                  'Protection Famille',
                  '150 000 €',
                  'Capital garanti',
                  Icons.family_restroom,
                  colorScheme.tertiary,
                ),
              ],
            ),
          ),
          
          // Documents
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mes documents',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Liste de documents
                _buildDocumentItem(
                  context,
                  'Relevé annuel PER',
                  '15/01/2023',
                  Icons.description,
                ),
                
                _buildDocumentItem(
                  context,
                  'Relevé annuel Assurance Vie',
                  '10/01/2023',
                  Icons.description,
                ),
                
                _buildDocumentItem(
                  context,
                  'Attestation fiscale',
                  '28/02/2023',
                  Icons.receipt_long,
                ),
                
                _buildDocumentItem(
                  context,
                  'Conditions générales Prévoyance',
                  '05/06/2022',
                  Icons.gavel,
                ),
              ],
            ),
          ),
          
          // Paramètres du compte
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paramètres',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Liste de paramètres
                _buildSettingsItem(
                  context,
                  'Informations personnelles',
                  Icons.person,
                ),
                
                _buildSettingsItem(
                  context,
                  'Sécurité et connexion',
                  Icons.security,
                ),
                
                _buildSettingsItem(
                  context,
                  'Notifications',
                  Icons.notifications,
                ),
                
                _buildSettingsItem(
                  context,
                  'Confidentialité',
                  Icons.privacy_tip,
                ),
                
                const SizedBox(height: 16),
                
                // Bouton de déconnexion
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout),
                    label: const Text('Déconnexion'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
  
  Widget _buildContractCard(
    BuildContext context,
    String title,
    String subtitle,
    String amount,
    String performance,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valeur actuelle',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      amount,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Chip(
                  label: Text(performance),
                  backgroundColor: color.withOpacity(0.1),
                  labelStyle: TextStyle(color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDocumentItem(
    BuildContext context,
    String title,
    String date,
    IconData icon,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(title),
      subtitle: Text(date),
      trailing: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {},
      ),
    );
  }
  
  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}