import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/oroneo/oroneo_app_bar.dart';

class OroneoSimulationDashboard extends StatefulWidget {
  final VoidCallback onBackPressed;

  const OroneoSimulationDashboard({
    super.key,
    required this.onBackPressed,
  });

  @override
  State<OroneoSimulationDashboard> createState() => _OroneoSimulationDashboardState();
}

class _OroneoSimulationDashboardState extends State<OroneoSimulationDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Variables pour les sliders et switches
  double _ageRetraite = 64;
  bool _avecPER = false;
  double _epargneMensuelle = 150;
  double _rachatTrimestres = 0;
  bool _isProfileExpanded = false;  // Ajout de la variable manquante

  Widget _buildSvgIcon(String iconName, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/oroneo/icons/$iconName.svg',
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      child: Column(
        children: [
          // En-tête toujours visible
          ListTile(
            leading: _buildSvgIcon('person', size: 48, color: colorScheme.primary),
            title: Text(
              'John Doe',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('47 ans', style: theme.textTheme.bodyLarge),
            trailing: IconButton(
              icon: _buildSvgIcon(
                _isProfileExpanded ? 'chevron_up' : 'chevron_down',
                color: colorScheme.primary,
              ),
              onPressed: () {
                setState(() {
                  _isProfileExpanded = !_isProfileExpanded;
                });
              },
            ),
          ),
          // Contenu expansible
          if (_isProfileExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildInfoChip(context, 'Salaire', '45 000 €/an'),
                  _buildInfoChip(context, 'PER', 'Oui - 150 €/mois'),
                  _buildInfoChip(context, 'Enfants', '2'),
                  _buildInfoChip(context, 'Statut', 'Marié(e)'),
                  _buildInfoChip(context, 'Profession', 'Salarié(e)'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: theme.colorScheme.surfaceVariant,
    );
  }

  Widget _buildCurrentSituationCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Votre situation actuelle',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '64 ans',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Âge de départ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: colorScheme.onPrimaryContainer.withOpacity(0.2),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '2 450 €',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pension mensuelle',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Taux de remplacement : 75%',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Le taux de remplacement représente le pourcentage de votre dernier salaire que vous toucherez à la retraite',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimaryContainer.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimulatorCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jouez avec vos variables',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text('Âge de départ à la retraite'),
            Slider(
              value: _ageRetraite,
              min: 64,
              max: 75,
              divisions: 11,
              label: '${_ageRetraite.round()} ans',
              onChanged: (value) {
                setState(() {
                  _ageRetraite = value;
                });
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Épargne avec un PER'),
              value: _avecPER,
              onChanged: (bool value) {
                setState(() {
                  _avecPER = value;
                });
              },
            ),
            if (_avecPER) ...[
              const SizedBox(height: 16),
              Text('Épargne mensuelle PER'),
              Slider(
                value: _epargneMensuelle,
                min: 150,
                max: 1500,
                divisions: 27,
                label: '${_epargneMensuelle.round()}€',
                onChanged: (value) {
                  setState(() {
                    _epargneMensuelle = value;
                  });
                },
              ),
            ],
            const SizedBox(height: 16),
            Text('Rachat de trimestres'),
            Slider(
              value: _rachatTrimestres,
              min: 0,
              max: 36,
              divisions: 36,
              label: '${_rachatTrimestres.round()} trimestres',
              onChanged: (value) {
                setState(() {
                  _rachatTrimestres = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPensionChart(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Évolution de votre pension',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 3500,
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 2450,
                          color: colorScheme.primary,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 3500,
                            color: colorScheme.surfaceVariant,
                          ),
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 2650,
                          color: colorScheme.primary,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 3500,
                            color: colorScheme.surfaceVariant,
                          ),
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: colorScheme.secondaryContainer,
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.round()}€',
                          TextStyle(
                            color: colorScheme.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}€',
                            style: theme.textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${(value + 64).toInt()} ans',
                            style: theme.textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      color: colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Impact sur votre retraite',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSvgIcon('lightbulb', color: colorScheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Text(
                  'Recommandations',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_ageRetraite.round()} ans',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Âge de départ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: colorScheme.onSecondaryContainer.withOpacity(0.2),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '2 850 €',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pension mensuelle',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Nouveau taux de remplacement : 82%',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // Action pour mettre en place le plan
                },
                child: const Text('Je veux mettre en place ce plan !'),
              ),
            ),
          ],
        ),
      ),
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
        onBackPressed: widget.onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '📊 Votre simulation retraite personnelle',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildProfileCard(context),
          const SizedBox(height: 16),
          _buildCurrentSituationCard(context),
          const SizedBox(height: 16),
          _buildSimulatorCard(context),
          const SizedBox(height: 16),
          _buildPensionChart(context),  // Ajout de l'histogramme ici
          const SizedBox(height: 16),
          _buildResultCard(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}