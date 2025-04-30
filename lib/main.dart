import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme_controller.dart';
import 'views/home_view.dart';
import 'themes/oroneo_theme.dart'; // Importer le thème Oroneo
import 'package:m3builderai/views/screens/oroneo_login_screen.dart'; // Ajout de l'import manquant
import 'views/screens/oroneo_home_screen.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        print("MyApp rebuilding with themeMode: ${themeController.themeMode}");
        
        // Vous pouvez choisir d'utiliser le thème Oroneo par défaut
        // ou de le proposer comme option dans ThemeController
        return MaterialApp(
          title: 'Oroneo Theme Builder',
          theme: themeController.lightTheme, // Ou OroneoTheme.lightTheme
          darkTheme: themeController.darkTheme, // Ou OroneoTheme.darkTheme
          themeMode: themeController.themeMode,
          home: const HomeView(),
        );
      },
    );
  }
}

// Suppression de la fonction onLoginSuccess qui était en dehors d'une classe
