import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class OroneoDashScreen extends StatefulWidget {
  final VoidCallback onCreateAccount;
  final VoidCallback onLogin;

  const OroneoDashScreen({
    super.key, 
    required this.onCreateAccount, 
    required this.onLogin
  });

  @override
  State<OroneoDashScreen> createState() => _OroneoDashScreenState();
}

class _OroneoDashScreenState extends State<OroneoDashScreen> {
  int _currentCarouselIndex = 0;
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'Votre assistant personnel IA finance',
      'description': 'Obtenez des conseils financiers personnalisés grâce à notre IA',
      'icon': Icons.assistant,
    },
    {
      'title': 'Simulateur Retraite personnalisé',
      'description': 'Planifiez votre retraite avec précision',
      'icon': Icons.calculate,
    },
    {
      'title': 'Je défiscalise avec Oroneo',
      'description': 'Optimisez votre fiscalité simplement',
      'icon': Icons.savings,
    },
    {
      'title': 'Je prépare l\'avenir avec Oroneo',
      'description': 'Des solutions adaptées à vos projets de vie',
      'icon': Icons.trending_up,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Oroneo
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Image.asset(
                    'assets/oroneo/images/logo.png',
                    height: 60,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.auto_graph,
                        size: 60,
                        color: Colors.deepPurple,
                      );
                    },
                  ),
                ),
                
                // Carousel
                FlutterCarousel(
                  items: _carouselItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  item['icon'],
                                  size: 48,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  item['title'],
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['description'],
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                  ),
                ),
                
                // Indicateurs de carousel
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _carouselItems.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentCarouselIndex == entry.key
                            ? theme.colorScheme.primary
                            : theme.colorScheme.primary.withOpacity(0.3),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 24),
                
                // Texte descriptif
                Text(
                  'Oroneo, votre IA personnelle gratuite pour gérer votre retraite, vos finances et préparer votre avenir sereinement.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),
                
                // CTA principal
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: widget.onCreateAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'CRÉER UN COMPTE MAINTENANT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Lien de connexion
                TextButton(
                  onPressed: widget.onLogin,
                  child: Text(
                    'J\'ai déjà un compte, je me connecte',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}