import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/oroneo/oroneo_app_bar.dart';

class OroneoSimulationScreen extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onStartSimulation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OroneoSimulationScreen({
    super.key,
    required this.onBackPressed,
    required this.onStartSimulation,
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
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: OroneoAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onBackPressed: onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16), // Réduction du padding horizontal
        children: [
          // Carte d'information sur la procédure
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 4), // Ajout d'une marge plus petite
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Simulation Retraite',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Notre assistant va vous guider pour réaliser une simulation personnalisée de votre retraite.',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Carte de chat avec l'IA
          Card(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio: 3/4,
                                child: Image.asset(
                                  'assets/oroneo/images/claire.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Pour réaliser votre simulation, j\'ai besoin que vous répondiez à quelques questions. On commence ?',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onStartSimulation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Commencer ma simulation maintenant !',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Carte des informations collectées
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ExpansionTile(
                initiallyExpanded: false,
                title: Text(
                  'Vos données pour notre simulation',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Nom', 'Doe'),
                        _buildInfoRow('Prénom', 'John'),
                        _buildInfoRow('Age', ''),
                        _buildInfoRow('Sexe', ''),
                        _buildInfoRow('Statut marital', ''),
                        _buildInfoRow('Nombre d\'enfants', ''),
                        _buildInfoRow('Age des enfants', ''),
                        _buildInfoRow('Salaire annuel', ''),
                        _buildInfoRow('Fichiers partagés', '0 fichier'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Carte d'aide
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSvgIcon(
                        'support_agent',
                        size: 32,
                        color: colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Besoin d\'aide ?',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Vous vous sentez perdu ou vous souhaitez des conseils personnalisés ? Nos conseillers sont là pour vous accompagner dans votre projet retraite.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          // Action à implémenter
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSvgIcon(
                              'calendar_month',
                              size: 24,
                              color: colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Prendre rendez-vous maintenant !',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value.isEmpty ? '---' : value),
        ],
      ),
    );
  }
}