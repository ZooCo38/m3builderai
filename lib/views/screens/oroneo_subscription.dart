import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/oroneo/oroneo_app_bar.dart';
import 'oroneo_subscription_chat.dart';

class OroneoSubscription extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onChatNavigation;

  const OroneoSubscription({
    super.key,
    required this.onBackPressed,
    required this.onChatNavigation,
  });

  Widget _buildSvgIcon(String assetName, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/oroneo/icons/$assetName.svg',
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: OroneoAppBar(
        onMenuPressed: () {},
        onBackPressed: onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '💰 Souscription à votre plan retraite',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Carte récapitulative du plan
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Votre plan personnalisé',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: _buildSvgIcon('savings', color: colorScheme.primary),
                    title: const Text('PER Oroneo'),
                    subtitle: const Text('Plan d\'Épargne Retraite'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: _buildSvgIcon('euro', color: colorScheme.primary),
                    title: const Text('150 € / mois'),
                    subtitle: const Text('Versements programmés'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: _buildSvgIcon('calendar_month', color: colorScheme.primary),
                    title: const Text('25 ans'),
                    subtitle: const Text('Durée d\'investissement'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Carte des avantages fiscaux
          Card(
            color: colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSvgIcon('shield', color: colorScheme.onSecondaryContainer),
                      const SizedBox(width: 8),
                      Text(
                        'Avantages fiscaux',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Économisez jusqu\'à 500 € d\'impôts par an',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Les versements sur votre PER sont déductibles de votre revenu imposable dans la limite de 10% de vos revenus professionnels.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Carte des documents requis
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Documents nécessaires',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: _buildSvgIcon('document', color: colorScheme.primary),
                    title: const Text('Pièce d\'identité'),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                  const Divider(),
                  ListTile(
                    leading: _buildSvgIcon('document', color: colorScheme.primary),
                    title: const Text('Justificatif de domicile'),
                    trailing: const Icon(Icons.upload),
                  ),
                  const Divider(),
                  ListTile(
                    leading: _buildSvgIcon('document', color: colorScheme.primary),
                    title: const Text('RIB'),
                    trailing: const Icon(Icons.upload),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Bouton de souscription
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                onChatNavigation();
              },
              child: const Text('Démarrer avec Claire'),
            ),
          ),
        ],
      ),
    );
  }
}