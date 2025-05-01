import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m3builderai/views/screens/oroneo_login_screen.dart';
import 'package:m3builderai/views/screens/oroneo_home_screen.dart';
import 'package:m3builderai/views/screens/oroneo_chat_screen.dart'; // Ajout de l'import manquant

class MobilePreview extends StatefulWidget {
  const MobilePreview({super.key});

  @override
  State<MobilePreview> createState() => _MobilePreviewState();
}

class _MobilePreviewState extends State<MobilePreview> {
  int _currentCarouselIndex = 0;
  bool _showLoginScreen = false;
  bool _showHomeScreen = false;
  bool _showChatScreen = false;  // Nouvel état pour l'écran de chat
  
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
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Container(
        width: 380,
        height: 844,
        decoration: BoxDecoration(
          color: colorScheme.background, // Utiliser la couleur du thème
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.black,
            width: 10,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              // Status Bar
              Container(
                height: 30,
                color: colorScheme.surface, // Utiliser la couleur du thème
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:30',
                      style: theme.textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.signal_cellular_4_bar, size: 16),
                        const SizedBox(width: 4),
                        const Icon(Icons.wifi, size: 16),
                        const SizedBox(width: 4),
                        const Icon(Icons.battery_full, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Contenu principal - Dashboard Oroneo ou écran de connexion
              Expanded(
                child: _showLoginScreen 
                    ? OroneoLoginScreen(
                        onBackPressed: () {
                          setState(() {
                            _showLoginScreen = false;
                          });
                        },
                        onLoginSuccess: () {
                          setState(() {
                            _showLoginScreen = false;
                            _showHomeScreen = true;  // Afficher l'écran d'accueil
                          });
                        },
                        onRegisterSuccess: () {
                          setState(() {
                            _showLoginScreen = false;
                            _showHomeScreen = true;  // Afficher l'écran d'accueil
                          });
                        },
                      )
                    : _showHomeScreen 
                        ? OroneoHomeScreen(
                            onChatNavigation: () {
                              setState(() {
                                _showHomeScreen = false;
                                _showChatScreen = true;
                              });
                            },
                          )
                        : _showChatScreen
                            ? OroneoChatScreen(
                                onBackPressed: () {
                                  setState(() {
                                    _showChatScreen = false;
                                    _showHomeScreen = true;
                                  });
                                },
                              )
                            : Scaffold(
                        backgroundColor: colorScheme.background,
                        body: SafeArea(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Logo Oroneo SVG
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                                      child: SvgPicture.asset(
                                        'assets/oroneo/logos/Logodark.svg',
                                        height: 60,
                                        colorFilter: ColorFilter.mode(
                                          colorScheme.onBackground, // Utiliser la couleur du thème
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    
                                    // Carousel avec PageView
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: PageView.builder(
                                        controller: PageController(viewportFraction: 0.95),
                                        itemCount: _carouselItems.length,
                                        onPageChanged: (index) {
                                          setState(() {
                                            _currentCarouselIndex = index;
                                          });
                                        },
                                        itemBuilder: (context, index) {
                                          final item = _carouselItems[index];
                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                            decoration: BoxDecoration(
                                              color: colorScheme.inverseSurface, // Utiliser la couleur du thème
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(24.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item['title'],
                                                    style: theme.textTheme.titleMedium?.copyWith(
                                                      color: colorScheme.onInverseSurface, // Utiliser la couleur du thème
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text(
                                                    item['description'],
                                                    style: theme.textTheme.bodySmall?.copyWith(
                                                      color: colorScheme.onInverseSurface.withOpacity(0.7), // Utiliser la couleur du thème
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    
                                    // Indicateurs de carousel
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 24.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: _carouselItems.asMap().entries.map((entry) {
                                          return Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _currentCarouselIndex == entry.key
                                                  ? colorScheme.primary // Utiliser la couleur du thème
                                                  : colorScheme.primary.withOpacity(0.3),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    
                                    // Texte descriptif
                                    Text(
                                      'Oroneo, votre IA personnelle gratuite pour gérer votre retraite, vos finances et préparer votre avenir sereinement.',
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color: colorScheme.onBackground, // Utiliser la couleur du thème
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    
                                    const SizedBox(height: 60),
                                    
                                    // CTA principal
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _showLoginScreen = true;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: colorScheme.primary,
                                          foregroundColor: colorScheme.onPrimary,
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
                                      onPressed: () {
                                        setState(() {
                                          _showLoginScreen = true;
                                        });
                                      },
                                      child: Text(
                                        'J\'ai déjà un compte, je me connecte',
                                        style: TextStyle(
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              
              // Home indicator
              Container(
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}