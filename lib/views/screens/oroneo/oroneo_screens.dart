import 'package:flutter/material.dart';
import 'oroneo_dash_screen.dart';
import 'oroneo_login_screen.dart';
import 'oroneo_home_screen.dart';
import 'oroneo_chat_screen.dart';
import 'oroneo_client_account_screen.dart';

class OroneoScreens extends StatefulWidget {
  const OroneoScreens({super.key});

  @override
  State<OroneoScreens> createState() => _OroneoScreensState();
}

class _OroneoScreensState extends State<OroneoScreens> {
  int _currentScreenIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: _currentScreenIndex >= 2 ? _buildBottomNavBar() : null,
      floatingActionButton: _currentScreenIndex == 2 
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _currentScreenIndex = 3; // Navigate to chat screen
                });
              },
              icon: const Icon(Icons.chat),
              label: const Text('Assistant'),
            ) 
          : null,
    );
  }
  
  Widget _buildCurrentScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return OroneoDashScreen(
          onCreateAccount: () {
            setState(() {
              _currentScreenIndex = 1; // Navigate to login/register screen
            });
          },
          onLogin: () {
            setState(() {
              _currentScreenIndex = 1; // Navigate to login/register screen
            });
          },
        );
      case 1:
        return OroneoLoginScreen(
          onLogin: () {
            setState(() {
              _currentScreenIndex = 2; // Navigate to home screen after login
            });
          },
          onRegister: () {
            setState(() {
              _currentScreenIndex = 2; // Navigate to home screen after registration
            });
          },
        );
      case 2:
        return OroneoHomeScreen(
          onChatStart: () {
            setState(() {
              _currentScreenIndex = 3; // Navigate to chat screen
            });
          },
        );
      case 3:
        return const OroneoChatScreen();
      case 4:
        return OroneoClientAccountScreen(
          onBackToHome: () {
            setState(() {
              _currentScreenIndex = 2; // Retour à l'écran d'accueil
            });
          },
        );
      default:
        return OroneoDashScreen(
          onCreateAccount: () {
            setState(() {
              _currentScreenIndex = 1;
            });
          },
          onLogin: () {
            setState(() {
              _currentScreenIndex = 1;
            });
          },
        );
    }
  }
  
  Widget _buildBottomNavBar() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return BottomNavigationBar(
      currentIndex: _currentScreenIndex - 2, // Adjust index for bottom nav items
      onTap: (index) {
        setState(() {
          _currentScreenIndex = index + 2; // Adjust to match screen indices
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Accueil',
          backgroundColor: colorScheme.surface,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat),
          label: 'Assistant',
          backgroundColor: colorScheme.surface,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: 'Compte',
          backgroundColor: colorScheme.surface,
        ),
      ],
    );
  }
}