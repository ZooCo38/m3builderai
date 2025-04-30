import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OroneoLoginScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onLoginSuccess;
  final VoidCallback onRegisterSuccess;

  const OroneoLoginScreen({
    super.key, 
    required this.onBackPressed,
    required this.onLoginSuccess,
    required this.onRegisterSuccess,
  });

  @override
  State<OroneoLoginScreen> createState() => _OroneoLoginScreenState();
}

class _OroneoLoginScreenState extends State<OroneoLoginScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Bouton retour
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
                      onPressed: widget.onBackPressed,
                    ),
                  ),
                  
                  // Logo Oroneo
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                    child: SvgPicture.asset(
                      'assets/oroneo/logos/Logodark.svg',
                      height: 50,
                      colorFilter: ColorFilter.mode(
                        colorScheme.onBackground,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  
                  // Titre
                  Text(
                    'Bienvenue sur Oroneo',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Sous-titre
                  Text(
                    'Créez un compte ou connectez-vous pour continuer',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Bouton Apple
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        // Appeler le callback de succès de connexion
                        widget.onLoginSuccess();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: colorScheme.surface,
                        side: BorderSide(color: colorScheme.outline),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/oroneo/icons/Applelogo.svg',
                            height: 20,
                            colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),// Essayez sans colorFilter pour voir si le SVG s'affiche
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Continuer avec Apple',
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Bouton Google
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        // Utiliser le callback fourni au widget
                        widget.onLoginSuccess();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colorScheme.outline),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/oroneo/icons/GoogleGlogo.svg',
                            height: 20,
                            // Essayez sans colorFilter pour voir si le SVG s'affiche
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Continuer avec Google',
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      children: [
                        Expanded(child: Divider(color: colorScheme.outline)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OU',
                            style: TextStyle(color: colorScheme.onBackground.withOpacity(0.7)),
                          ),
                        ),
                        Expanded(child: Divider(color: colorScheme.outline)),
                      ],
                    ),
                  ),
                  
                  // Champ Email
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Entrez votre adresse email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Champ Mot de passe
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      hintText: 'Entrez votre mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Logique de récupération de mot de passe
                      },
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(color: colorScheme.primary),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Bouton de connexion
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Si le formulaire est valide, appeler le callback de succès
                          widget.onLoginSuccess();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'SE CONNECTER',
                        style: TextStyle(color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Lien d'inscription
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vous n\'avez pas de compte ?',
                        style: TextStyle(color: colorScheme.onBackground),
                      ),
                      TextButton(
                        onPressed: () {
                          // Basculer vers l'écran d'inscription
                          widget.onRegisterSuccess();
                        },
                        child: Text(
                          'S\'inscrire',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Conditions d'utilisation
                  Text(
                    'En continuant, vous acceptez nos Conditions d\'utilisation et notre Politique de confidentialité',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}