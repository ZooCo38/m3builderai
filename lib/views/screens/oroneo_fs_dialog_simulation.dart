import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/oroneo/oroneo_app_bar.dart';

class OroneoFsDialogSimulation extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onViewSimulation;  // Nouveau callback
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OroneoFsDialogSimulation({
    super.key,
    required this.onClose,
    required this.onViewSimulation,  // Ajout du paramètre
  });

  Widget _buildSvgIcon(String assetName, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/oroneo/icons/$assetName.svg',
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  final List<String> _steps = [
    'Informations personnelles',
    'Relevé de carrière',
    'Statuts actuels et objectifs'
  ];
  final int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: OroneoAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onBackPressed: onClose,
      ),
      body: Column(
        children: [
          // Carte d'avancement fixe
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: (_currentStep + 1) / _steps.length,
                      strokeWidth: 8,
                      backgroundColor: colorScheme.surfaceVariant,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _steps.asMap().entries.map((entry) {
                        final isCurrentStep = entry.key == _currentStep;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            entry.value,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: isCurrentStep ? FontWeight.bold : FontWeight.normal,
                              color: isCurrentStep ? colorScheme.primary : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Zone de chat scrollable
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Messages existants
                _buildAIMessage(
                  context,
                  "Bonjour John ! Je suis Claire Monet, votre conseillère retraite numérique. Je vais vous aider à constituer votre dossier pour simuler votre future retraite. Nous commencerons par obtenir votre relevé de carrière, document indispensable pour une estimation précise.\n\nPuis-je vous poser quelques questions pour vous guider ?",
                ),
                const SizedBox(height: 16),
                _buildUserMessage(context, "Bonjour Claire, oui bien sûr."),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "Super. Voici les premières informations dont j'ai besoin :\n\nVotre date de naissance\n\nVotre numéro de sécurité sociale\n\nAvez-vous déjà créé un compte sur le site info-retraite.fr ?",
                ),
                const SizedBox(height: 16),
                _buildUserMessage(
                  context,
                  "Je suis né le 15 mars 1980. Mon numéro de sécu commence par 18003... et non, je n'ai jamais créé de compte.",
                ),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "Merci John ! Voici les prochaines étapes pour créer votre compte et obtenir votre relevé de carrière :\n\n✅ Rendez-vous sur info-retraite.fr\n\n✅ Cliquez sur « Mon compte retraite »\n\n✅ Créez un compte via FranceConnect (en utilisant votre compte impots.gouv.fr, ameli.fr ou La Poste)\n\n✅ Une fois connecté, cliquez sur « Mon relevé de carrière »\n\nSouhaitez-vous que je reste avec vous pendant cette étape pour vous guider en direct ?",
                ),
                const SizedBox(height: 16),
                _buildUserMessage(
                  context,
                  "Oui, je veux bien. Je suis sur le site, je vois FranceConnect.",
                ),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "Parfait. Connectez-vous avec l'identifiant de votre choix. Une fois connecté, cherchez l'onglet \"Mes droits à la retraite\", puis \"Mon relevé de carrière\".\n\nPendant que vous faites cela, pouvez-vous aussi me dire :\n\nÀ quel âge souhaitez-vous partir à la retraite ?\n\nQuel est votre statut actuel ? (salarié, indépendant, fonctionnaire, etc.)\n\nAvez-vous eu des périodes de chômage, congé parental, ou arrêt maladie longue durée ?",
                ),
                const SizedBox(height: 16),
                _buildUserMessage(
                  context,
                  "Je vise 64 ans pour le départ. Je suis salarié depuis toujours. J'ai eu 2 ans de chômage après mes études, et 6 mois d'arrêt maladie en 2017.",
                ),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "Merci John, c'est très utile !\n\n📝 Voici ce que je note :\n\nDépart souhaité à 64 ans\n\nCarrière salariée\n\n2 ans de chômage (à préciser les années)\n\n6 mois d'arrêt maladie (2017)\n\nUne fois que vous avez téléchargé votre relevé de carrière, vous pouvez me l'envoyer ici pour que je l'analyse et que nous lancions la simulation complète.\n\nSouhaitez-vous que je vous aide à vérifier s'il contient des anomalies (trous, trimestres manquants, etc.) ?",
                ),
                const SizedBox(height: 16),
                _buildUserMessage(
                  context,
                  "Oui, je viens de le télécharger. Je peux te l'envoyer ?",
                ),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "Absolument ! Envoyez-le ici, et je l'analyse pour vous. Je vous indiquerai si tout est correct ou s'il faut contacter une caisse de retraite.",
                ),
                const SizedBox(height: 16),
                _buildUserMessage(
                  context,
                  "Voilà, j'ai envoyé le fichier de mon relevé de carrière.",
                  attachments: [
                    Chip(
                      label: const Text('releve_carriere.pdf'),
                      avatar: _buildSvgIcon('document', size: 16, color: colorScheme.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "📄 Parfait, John. J'ai bien reçu votre relevé de carrière et je viens de l'analyser.\n\n"
                  "🎯 Si je récapitule :\n\n"
                  "👤 Vous êtes un homme, âgé de 47 ans\n\n"
                  "💍 Statut marital : Marié\n\n"
                  "👨‍👩‍👧‍👦 Nombre d'enfants : 2\n\n"
                  "🏢 Profession : Salarié depuis le début de votre carrière\n\n"
                  "📉 Périodes spécifiques :\n"
                  "- 2 ans de chômage après vos études (entre 2003 et 2005)\n"
                  "- 6 mois d'arrêt maladie en 2017\n\n"
                  "🎯 Âge de départ souhaité : 64 ans\n\n"
                  "🧾 Relevé de carrière fourni et complet, sans anomalies majeures détectées\n\n"
                  "Est-ce que toutes ces informations sont correctes avant que je lance la simulation de votre retraite ?",
                  action: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                    child: const Text('Lancer la simulation'),
                  ),
                ),
                const SizedBox(height: 16),
                _buildUserMessage(context, "Oui, c'est bien ça. Tu peux lancer."),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "🔄 Très bien John. Je lance maintenant votre simulation personnalisée de retraite.\n\n"
                  "⏳ Cela prendra quelques minutes. Vous recevrez une notification dès que la simulation sera terminée, avec :\n\n"
                  "📈 Un récapitulatif de vos droits acquis\n\n"
                  "📆 Une projection de votre âge de départ à taux plein\n\n"
                  "💰 Une estimation de votre pension mensuelle nette\n\n"
                  "Je reste à votre disposition si vous avez des questions pendant le traitement.",
                ),
                const SizedBox(height: 16),
                _buildAIMessage(
                  context,
                  "✅ Votre simulation est terminée, John !\n"
                  "👉 Accédez à votre simulation ici :",
                  action: ElevatedButton(
                    onPressed: onViewSimulation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                    child: const Text('Voir ma simulation'),
                  ),
                ),
              ],
            ),
          ),
          
          // Zone de saisie unifiée
          Container(
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
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Votre message...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: _buildSvgIcon('mic', color: colorScheme.primary),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: _buildSvgIcon('send', color: colorScheme.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                        avatar: _buildSvgIcon('attachment', size: 18, color: colorScheme.primary),
                        label: const Text('Fichier'),
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                      const SizedBox(width: 8),
                      ActionChip(
                        avatar: _buildSvgIcon('image', size: 18, color: colorScheme.primary),
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

  Widget _buildAIMessage(BuildContext context, String message, {Widget? action}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
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
          if (action != null) ...[
            const SizedBox(height: 12),
            action,
          ],
        ],
      ),
    );
  }

  Widget _buildUserMessage(BuildContext context, String message, {List<Widget>? attachments}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
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
              if (attachments != null) ...[
                const SizedBox(height: 8),
                ...attachments,
              ],
            ],
          ),
        ),
      ],
    );
  }
}