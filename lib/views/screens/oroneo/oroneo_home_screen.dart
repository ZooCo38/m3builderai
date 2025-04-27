import 'package:flutter/material.dart';

class OroneoHomeScreen extends StatelessWidget {
  const OroneoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec salutation
          Container(
            padding: const EdgeInsets.all(24),
            color: colorScheme.primaryContainer.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bonjour, Thomas',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Que puis-je faire pour vous aujourd\'hui ?',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          
          // Section chat avec l'IA
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input chat
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Quel est votre projet ?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Boutons d'action rapide
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildQuickActionChip('Aide-moi pour ma retraite', colorScheme),
                    _buildQuickActionChip('Je veux défiscaliser', colorScheme),
                    _buildQuickActionChip('J\'ai un projet à financer', colorScheme),
                    _buildQuickActionChip('Je protège ma famille', colorScheme),
                  ],
                ),
              ],
            ),
          ),
          
          // Cartes de services
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nos services',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Carte simulation retraite
                _buildServiceCard(
                  context,
                  'Simulation retraite',
                  'Estimez vos revenus futurs et préparez votre retraite sereinement',
                  Icons.trending_up,
                  colorScheme.primary,
                ),
                
                // Carte épargne et défiscalisation
                _buildServiceCard(
                  context,
                  'J\'épargne, je défiscalise',
                  'Optimisez votre fiscalité avec nos solutions d\'investissement',
                  Icons.savings,
                  colorScheme.secondary,
                ),
                
                // Carte protection famille
                _buildServiceCard(
                  context,
                  'Je protège ma famille',
                  'Assurez l\'avenir de vos proches avec nos solutions de protection',
                  Icons.family_restroom,
                  colorScheme.tertiary,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionChip(String label, ColorScheme colorScheme) {
    return FilterChip(
      label: Text(label),
      onSelected: (_) {},
      backgroundColor: colorScheme.surfaceVariant,
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
    );
  }
  
  Widget _buildServiceCard(
    BuildContext context,
    String title, 
    String description, 
    IconData icon, 
    Color color
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
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
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}