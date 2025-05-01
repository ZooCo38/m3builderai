import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/oroneo/oroneo_app_bar.dart';

class OroneoFsDialogSimulation extends StatelessWidget {
  final VoidCallback onClose;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OroneoFsDialogSimulation({
    super.key,
    required this.onClose,
  });

  Widget _buildSvgIcon(String assetName, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/oroneo/icons/$assetName.svg',
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  final List<String> _steps = [
    'Informations personnelles',
    'Relevé de carrière',
    'Statuts actuels et objectifs'
  ];
  final int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: OroneoAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onBackPressed: onClose,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Simulation Retraite',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Carte d'avancement
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Indicateur de progression circulaire
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: (_currentStep + 1) / _steps.length,
                      strokeWidth: 8,
                      backgroundColor: colorScheme.surfaceVariant,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Liste des étapes
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _steps.asMap().entries.map((entry) {
                        final isCurrentStep = entry.key == _currentStep;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            entry.value,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: isCurrentStep ? FontWeight.bold : FontWeight.normal,
                              color: isCurrentStep ? colorScheme.primary : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Interface de chat
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message de Claire avec photo
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: const AssetImage('assets/oroneo/images/claire.jpg'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Claire',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Bonjour ! Je suis Claire, votre assistante pour la simulation retraite. Toutes les informations que vous me confierez resteront strictement confidentielles. Cette simulation ne prendra que quelques minutes.',
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tout d\'abord, quelle est votre date de naissance ?',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
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
        ],
      ),
    );
  }
}