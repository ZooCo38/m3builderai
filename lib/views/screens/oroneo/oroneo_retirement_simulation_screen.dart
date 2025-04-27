import 'package:flutter/material.dart';

class OroneoRetirementSimulationScreen extends StatefulWidget {
  const OroneoRetirementSimulationScreen({super.key});

  @override
  State<OroneoRetirementSimulationScreen> createState() => _OroneoRetirementSimulationScreenState();
}

class _OroneoRetirementSimulationScreenState extends State<OroneoRetirementSimulationScreen> {
  // Valeurs par défaut pour la simulation
  double _currentAge = 40;
  double _retirementAge = 65;
  double _monthlyContribution = 300;
  double _annualIncome = 50000;
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de la page
            Text(
              'Simulation Retraite',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Estimez vos revenus à la retraite et optimisez votre épargne',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: 24),
            
            // Carte de résultats
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Capital estimé à la retraite',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_calculateRetirementCapital().toStringAsFixed(0)} €',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildResultItem(
                          context, 
                          'Rente mensuelle', 
                          '${(_calculateRetirementCapital() * 0.004).toStringAsFixed(0)} €',
                        ),
                        _buildResultItem(
                          context, 
                          'Économie d\'impôts', 
                          '${(_monthlyContribution * 12 * 0.3).toStringAsFixed(0)} €/an',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Paramètres de simulation
            Text(
              'Paramètres de simulation',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Âge actuel
            _buildSliderSection(
              context,
              'Âge actuel',
              '${_currentAge.toInt()} ans',
              _currentAge,
              25,
              60,
              (value) {
                setState(() {
                  _currentAge = value;
                  // S'assurer que l'âge de retraite est toujours supérieur à l'âge actuel
                  if (_retirementAge < _currentAge + 5) {
                    _retirementAge = _currentAge + 5;
                  }
                });
              },
            ),
            
            // Âge de départ à la retraite
            _buildSliderSection(
              context,
              'Âge de départ à la retraite',
              '${_retirementAge.toInt()} ans',
              _retirementAge,
              _currentAge + 5,
              75,
              (value) {
                setState(() {
                  _retirementAge = value;
                });
              },
            ),
            
            // Versement mensuel
            _buildSliderSection(
              context,
              'Versement mensuel',
              '${_monthlyContribution.toInt()} €',
              _monthlyContribution,
              50,
              1000,
              (value) {
                setState(() {
                  _monthlyContribution = value;
                });
              },
            ),
            
            // Revenu annuel
            _buildSliderSection(
              context,
              'Revenu annuel',
              '${_annualIncome.toInt()} €',
              _annualIncome,
              20000,
              150000,
              (value) {
                setState(() {
                  _annualIncome = value;
                });
              },
            ),
            
            const SizedBox(height: 24),
            
            // Bouton pour obtenir un conseil personnalisé
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat),
                label: const Text('Obtenir un conseil personnalisé'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bouton pour télécharger le rapport
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text('Télécharger le rapport'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  
  Widget _buildResultItem(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSliderSection(
    BuildContext context,
    String title,
    String value,
    double currentValue,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Slider(
          value: currentValue,
          min: min,
          max: max,
          divisions: ((max - min) / 5).round(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
  
  // Calcul simplifié du capital à la retraite
  double _calculateRetirementCapital() {
    final years = _retirementAge - _currentAge;
    final monthlyContributions = _monthlyContribution * 12 * years;
    final interestRate = 0.04; // 4% de rendement annuel moyen
    
    // Formule simplifiée pour le calcul du capital avec intérêts composés
    double capital = 0;
    for (int i = 0; i < years; i++) {
      capital = (capital + _monthlyContribution * 12) * (1 + interestRate);
    }
    
    return capital;
  }
}