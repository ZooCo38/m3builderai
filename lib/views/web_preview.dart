import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io' as io;

class WebPreview extends StatefulWidget {
  const WebPreview({Key? key}) : super(key: key);

  @override
  State<WebPreview> createState() => _WebPreviewState();
}

class _WebPreviewState extends State<WebPreview> {
  String _currentUrl = 'oroneo.fr';
  bool _isLoading = false;
  String _assetStatus = '';

  @override
  void initState() {
    super.initState();
    _checkAssets();
  }

  // Fonction pour vérifier l'existence des assets
  Future<void> _checkAssets() async {
    try {
      // Utiliser io.Platform.pathSeparator pour la compatibilité cross-platform
      final directory = io.Directory('${io.Directory.current.path}${io.Platform.pathSeparator}assets${io.Platform.pathSeparator}oroneo${io.Platform.pathSeparator}logos');
      
      if (await directory.exists()) {
        final files = await directory.list().toList();
        setState(() {
          _assetStatus = 'Dossier trouvé. Fichiers: ${files.map((f) => f.path.split(io.Platform.pathSeparator).last).join(', ')}';
        });
      } else {
        setState(() {
          _assetStatus = 'Dossier non trouvé: ${directory.path}';
        });
      }
    } catch (e) {
      setState(() {
        _assetStatus = 'Erreur: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    
    return Scaffold(
      backgroundColor: currentTheme.colorScheme.background,
      body: Column(
        children: [
          // Barre d'adresse du navigateur
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: currentTheme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Boutons de navigation
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                  tooltip: 'Retour',
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {},
                  tooltip: 'Suivant',
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    Future.delayed(const Duration(milliseconds: 800), () {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    });
                  },
                  tooltip: 'Actualiser',
                ),
                
                // Barre d'adresse
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: currentTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: currentTheme.colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 16,
                          color: currentTheme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _currentUrl,
                          style: TextStyle(
                            color: currentTheme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Boutons supplémentaires
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                  tooltip: 'Favoris',
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                  tooltip: 'Plus',
                ),
              ],
            ),
          ),
          
          // Contenu principal
          Expanded(
            child: _isLoading 
                ? Center(
                    child: CircularProgressIndicator(
                      color: currentTheme.colorScheme.primary,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indicateur de statut des assets (à supprimer après débogage)
                        if (_assetStatus.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            color: Colors.amber,
                            child: Text(
                              'Statut des assets: $_assetStatus',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        
                        // Header / Menu
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          color: currentTheme.colorScheme.surface,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Logo et liens de navigation
                              Row(
                                children: [
                                  // Logo Oroneo
                                  Row(
                                    children: [
                                      // Utilisation du logo SVG
                                      SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: SvgPicture.asset(
                                          'assets/oroneo/logos/Logodark.svg',
                                          semanticsLabel: 'Logo Oroneo',
                                          // Afficher un placeholder en cas d'erreur
                                          placeholderBuilder: (BuildContext context) => CircleAvatar(
                                            backgroundColor: currentTheme.colorScheme.primary,
                                            radius: 16,
                                            child: Text(
                                              'O',
                                              style: TextStyle(
                                                color: currentTheme.colorScheme.onPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'ORONEO',
                                        style: TextStyle(
                                          color: currentTheme.colorScheme.onSurface,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 32),
                                  // Liens de navigation
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Application'),
                                  ),
                                  const SizedBox(width: 16),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Qui sommes-nous'),
                                  ),
                                ],
                              ),
                              // Boutons de connexion/inscription
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    ),
                                    child: const Text('Se connecter'),
                                  ),
                                  const SizedBox(width: 16),
                                  FilledButton(
                                    onPressed: () {},
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    ),
                                    child: const Text('S\'inscrire'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Section Hero
                        Container(
                          width: double.infinity,
                          height: 600,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                currentTheme.colorScheme.primary,
                                currentTheme.colorScheme.tertiary,
                              ],
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Contenu texte
                              Positioned(
                                left: 80,
                                top: 120,
                                child: SizedBox(
                                  width: 500,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Votre Assistant IA personnel pour vos finances',
                                        style: TextStyle(
                                          color: currentTheme.colorScheme.onPrimary,
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        'Oroneo vous accompagne dans la gestion de vos finances, l\'optimisation de votre épargne et la préparation de votre retraite grâce à l\'intelligence artificielle.',
                                        style: TextStyle(
                                          color: currentTheme.colorScheme.onPrimary.withOpacity(0.9),
                                          fontSize: 18,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      FilledButton.icon(
                                        onPressed: () {},
                                        style: FilledButton.styleFrom(
                                          backgroundColor: currentTheme.colorScheme.onPrimary,
                                          foregroundColor: currentTheme.colorScheme.primary,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                        ),
                                        icon: const Icon(Icons.download),
                                        label: const Text('Télécharger l\'application'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Image de smartphone (à remplacer par une vraie image)
                              Positioned(
                                right: 80,
                                bottom: 0,
                                child: Container(
                                  width: 300,
                                  height: 500,
                                  decoration: BoxDecoration(
                                    color: currentTheme.colorScheme.surfaceVariant.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Image de l\'application',
                                      style: TextStyle(
                                        color: currentTheme.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Lame 1: Partenaires
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 80),
                          color: currentTheme.colorScheme.surface,
                          child: Column(
                            children: [
                              Text(
                                'Nos partenaires nous font confiance',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onSurface,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 48),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildPartnerLogo('SwissLife', currentTheme),
                                  _buildPartnerLogo('Generali', currentTheme),
                                  _buildPartnerLogo('Abeille', currentTheme),
                                  _buildPartnerLogo('BNP', currentTheme),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Lame 2: Simulation retraite
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
                          color: currentTheme.colorScheme.surfaceVariant,
                          child: Row(
                            children: [
                              // Image/Illustration
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: currentTheme.colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.bar_chart,
                                      size: 100,
                                      color: currentTheme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 80),
                              // Texte
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Votre simulation retraite personnalisée !',
                                      style: TextStyle(
                                        color: currentTheme.colorScheme.onSurfaceVariant,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'Obtenez une projection précise de votre future retraite en quelques minutes. Notre IA analyse votre situation et vous propose des solutions adaptées.',
                                      style: TextStyle(
                                        color: currentTheme.colorScheme.onSurfaceVariant,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    FilledButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.download),
                                      label: const Text('Télécharger l\'application'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Lame 3: Épargne et défiscalisation
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
                          color: currentTheme.colorScheme.surface,
                          child: Row(
                            children: [
                              // Texte
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'J\'épargne et je défiscalise avec ORONEO',
                                      style: TextStyle(
                                        color: currentTheme.colorScheme.onSurface,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'Optimisez votre épargne et réduisez vos impôts grâce à nos solutions personnalisées. Notre assistant IA vous guide vers les meilleurs placements.',
                                      style: TextStyle(
                                        color: currentTheme.colorScheme.onSurface,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    FilledButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.download),
                                      label: const Text('Télécharger l\'application'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 80),
                              // Image/Illustration
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: currentTheme.colorScheme.secondary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.savings,
                                      size: 100,
                                      color: currentTheme.colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Lame 4: Protection famille
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
                          color: currentTheme.colorScheme.surfaceVariant,
                          child: Row(
                            children: [
                              // Image/Illustration
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: currentTheme.colorScheme.tertiary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.family_restroom,
                                      size: 100,
                                      color: currentTheme.colorScheme.tertiary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 80),
                              // Texte
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Je protège ma famille',
                                      style: TextStyle(
                                        color: currentTheme.colorScheme.onSurfaceVariant,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'Assurez l\'avenir de vos proches avec nos solutions de protection. Assurance vie, prévoyance, transmission de patrimoine : nous vous accompagnons dans toutes vos démarches.',
                                      style: TextStyle(
                                        color: currentTheme.colorScheme.onSurfaceVariant,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    FilledButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.download),
                                      label: const Text('Télécharger l\'application'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Footer
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 80),
                          color: currentTheme.colorScheme.surfaceContainerHighest,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Liens texte
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Qui sommes-nous',
                                          style: TextStyle(
                                            color: currentTheme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Nos produits',
                                          style: TextStyle(
                                            color: currentTheme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Contact',
                                          style: TextStyle(
                                            color: currentTheme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'CGV',
                                          style: TextStyle(
                                            color: currentTheme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Infos légales',
                                          style: TextStyle(
                                            color: currentTheme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Logo
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: currentTheme.colorScheme.primary,
                                        radius: 16,
                                        child: Text(
                                          'O',
                                          style: TextStyle(
                                            color: currentTheme.colorScheme.onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'ORONEO',
                                        style: TextStyle(
                                          color: currentTheme.colorScheme.onSurfaceVariant,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Text(
                                '© 2023 Oroneo. Tous droits réservés.',
                                style: TextStyle(
                                  color: currentTheme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
  
  // Méthode pour construire les logos des partenaires
  Widget _buildPartnerLogo(String name, ThemeData theme) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  // Suppression des méthodes non utilisées
  Widget _buildColorCircle(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}