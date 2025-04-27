import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m3builderai/views/screens/home_screen.dart';
import 'package:m3builderai/views/screens/chat_screen.dart';
import 'package:m3builderai/views/screens/profile_screen.dart';
import 'screens/oroneo/oroneo_screens.dart';

class MobilePreview extends StatefulWidget {
  const MobilePreview({super.key});

  @override
  State<MobilePreview> createState() => _MobilePreviewState();
}

class _MobilePreviewState extends State<MobilePreview> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Utiliser les couleurs du thème actuel
    final colorScheme = Theme.of(context).colorScheme;
    
    return Center(
      child: Container(
        width: 380, // Ajusté à 380px
        height: 844, // Ajusté à 844px pour correspondre au ratio d'un téléphone moderne
        decoration: BoxDecoration(
          color: colorScheme.background, // Utiliser la couleur de fond du thème au lieu de noir
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
                height: 30, // Légèrement plus grand pour les téléphones modernes
                color: colorScheme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:30',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 12),
                        const SizedBox(width: 8),
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
              
              // Contenu principal qui change en fonction de l'index
              Expanded(
                child: _buildScreen(_currentIndex),
              ),
              
              // Bottom Navigation Bar
              Container(
                height: 80,
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(0, Icons.home, 'Home'),
                    _buildNavItem(1, Icons.message, 'Discuter'),
                    _buildNavItem(2, Icons.account_circle, 'Mon profil'),
                    _buildNavItem(3, Icons.auto_graph, 'Oroneo'),
                  ],
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
  
  Widget _buildNavItem(int index, IconData icon, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: isSelected 
                ? colorScheme.primaryContainer 
                : colorScheme.surfaceVariant,
            radius: 20,
            child: Icon(
              icon,
              color: isSelected 
                  ? colorScheme.onPrimaryContainer 
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected 
                  ? colorScheme.primary 
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ChatScreen();
      case 2:
        return const ProfileScreen();
      case 3:
        return const OroneoScreens();
      default:
        return const HomeScreen();
    }
  }
}