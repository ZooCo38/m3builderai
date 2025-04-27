// Dans oroneo_screens.dart, mettre à jour les imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m3builderai/views/screens/oroneo/oroneo_dash_screen.dart'; // Chemin absolu
import 'package:m3builderai/views/screens/oroneo/oroneo_login_screen.dart'; // Chemin absolu
import 'package:m3builderai/views/screens/oroneo/oroneo_home_screen.dart'; // Chemin absolu
import 'package:m3builderai/views/screens/oroneo/oroneo_chat_screen.dart'; // Chemin absolu
import 'package:m3builderai/views/screens/oroneo/oroneo_retirement_simulation_screen.dart'; // Chemin absolu
import 'package:m3builderai/views/screens/oroneo/oroneo_client_account_screen.dart'; // Chemin absolu

class OroneoScreens extends StatefulWidget {
  const OroneoScreens({super.key});

  @override
  State<OroneoScreens> createState() => _OroneoScreensState();
}

class _OroneoScreensState extends State<OroneoScreens> {
  int _currentOroneoScreen = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Liste des écrans Oroneo
    final List<Widget> oroneoScreens = [
      const OroneoDashScreen(),
      const OroneoLoginScreen(),
      const OroneoHomeScreen(),
      const OroneoChatScreen(),
      const OroneoRetirementSimulationScreen(),
      const OroneoClientAccountScreen(),
    ];
    
    return Column(
      children: [
        // App Bar
        Container(
          height: 56,
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.menu),
              // Remplacer le texte par le logo SVG
              SvgPicture.asset(
                'assets/oroneo/logos/Logodark.svg',
                height: 28,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface, // Utilise la couleur du texte du thème
                  BlendMode.srcIn,
                ),
                placeholderBuilder: (BuildContext context) => Container(
                  height: 28,
                  width: 84,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'ORONEO',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Icon(Icons.settings),
            ],
          ),
        ),
        
        // Navigation des écrans Oroneo
        Container(
          height: 50,
          color: colorScheme.surface,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              _buildOroneoNavButton('Accueil', 0),
              _buildOroneoNavButton('Login', 1),
              _buildOroneoNavButton('Dashboard', 2),
              _buildOroneoNavButton('Chat', 3),
              _buildOroneoNavButton('Retraite', 4),
              _buildOroneoNavButton('Compte', 5),
            ],
          ),
        ),
        
        // Contenu de l'écran Oroneo sélectionné
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentOroneoScreen = index;
              });
            },
            children: oroneoScreens,
          ),
        ),
      ],
    );
  }
  
  Widget _buildOroneoNavButton(String title, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _currentOroneoScreen == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentOroneoScreen = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}