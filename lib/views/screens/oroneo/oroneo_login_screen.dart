import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OroneoLoginScreen extends StatelessWidget {
  const OroneoLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            
            // Logo
            SvgPicture.asset(
              'assets/oroneo/logo_oroneo.svg',
              height: 60,
            ),
            
            const SizedBox(height: 40),
            
            // Titre
            Text(
              'Bienvenue',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Connectez-vous pour accéder à votre espace',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Boutons de connexion sociale
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.apple),
              label: const Text('Continuer avec Apple'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            
            const SizedBox(height: 16),
            
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.g_mobiledata, size: 32),
              label: const Text('Continuer avec Google'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'ou',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Formulaire de connexion
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            
            const SizedBox(height: 16),
            
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            
            const SizedBox(height: 8),
            
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Mot de passe oublié ?'),
              ),
            ),
            
            const SizedBox(height: 24),
            
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Se connecter'),
            ),
            
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pas encore de compte ?',
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('S\'inscrire'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}