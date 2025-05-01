import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/oroneo/oroneo_app_bar.dart';
import '../../widgets/oroneo/oroneo_drawer.dart';

class OroneoChatScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final VoidCallback onBackPressed;
  
  OroneoChatScreen({
    super.key,
    required this.onBackPressed,
  });

  Widget _buildSvgIcon(String assetName, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/oroneo/icons/$assetName.svg',
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: OroneoAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onBackPressed: onBackPressed,  // Ajout du callback pour le retour
      ),
      drawer: OroneoDrawer(
        onLogoutTap: () {
          // Gérer la déconnexion
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Message de l'IA
                _buildAIMessage(
                  context,
                  "Bonjour John, je suis Claire Monet, votre conseillère Oroneo. Je comprends que vous souhaitez en savoir plus sur la retraite. Je suis là pour vous aider à comprendre les différentes options qui s'offrent à vous. Que souhaitez-vous savoir en particulier ?",
                ),
                const SizedBox(height: 16),
                // Message de l'utilisateur
                _buildUserMessage(
                  context,
                  "Je voudrais savoir comment préparer ma retraite de manière efficace.",
                ),
              ],
            ),
          ),
          // Zone de saisie en bas
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              children: [
                // Zone de texte principale
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Votre message...',
                    filled: true,
                    fillColor: colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: _buildSvgIcon(
                            'mic',
                            color: colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: _buildSvgIcon(
                            'send',
                            color: colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  maxLines: null,
                ),
                // Zone des options (même couleur que le TextField)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      ActionChip(
                        avatar: _buildSvgIcon(
                          'attachment',
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        label: const Text('Fichier'),
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                      const SizedBox(width: 8),
                      ActionChip(
                        avatar: _buildSvgIcon(
                          'image',
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        label: const Text('Images'),
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIMessage(BuildContext context, String message) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text('CM', style: TextStyle(color: colorScheme.onPrimaryContainer)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Claire Monet',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(message),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserMessage(BuildContext context, String message) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: TextStyle(color: colorScheme.onPrimaryContainer),
            ),
          ),
        ),
      ],
    );
  }
}