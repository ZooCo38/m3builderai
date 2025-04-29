import 'package:flutter/material.dart';

class OroneoLoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const OroneoLoginScreen({
    super.key, 
    required this.onLogin, 
    required this.onRegister
  });

  @override
  State<OroneoLoginScreen> createState() => _OroneoLoginScreenState();
}

class _OroneoLoginScreenState extends State<OroneoLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _obscurePassword = true;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
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
                  
                  // Titre
                  Text(
                    _isLogin ? 'Connexion' : 'Créer un compte',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Boutons de connexion sociale
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.apple),
                          label: const Text('Apple'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.g_mobiledata),
                          label: const Text('Google'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Séparateur
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'ou',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Champ email
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Champ mot de passe
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
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
                      return null;
                    },
                  ),
                  
                  if (!_isLogin) ...[
                    const SizedBox(height: 16),
                    
                    // Champ confirmation mot de passe (uniquement pour l'inscription)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez confirmer votre mot de passe';
                        }
                        return null;
                      },
                    ),
                  ],
                  
                  const SizedBox(height: 8),
                  
                  // Lien mot de passe oublié (uniquement pour la connexion)
                  if (_isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Bouton principal
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_isLogin) {
                            widget.onLogin();
                          } else {
                            widget.onRegister();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _isLogin ? 'SE CONNECTER' : 'S\'INSCRIRE',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Lien pour basculer entre connexion et inscription
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin 
                          ? 'Pas encore de compte ? Inscrivez-vous' 
                          : 'Déjà un compte ? Connectez-vous',
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
      ),
    );
  }
}