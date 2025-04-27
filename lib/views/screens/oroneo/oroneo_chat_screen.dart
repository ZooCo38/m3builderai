import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OroneoChatScreen extends StatelessWidget {
  const OroneoChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        // En-tête de conversation
        Container(
          padding: const EdgeInsets.all(16),
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: SvgPicture.asset(
                  '../../../../assets/oroneo/blason_oroneo.svg',
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORONEO AI',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Votre conseiller financier',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Conversation
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Message de l'IA
              _buildAIMessage(
                'Bonjour ! Je suis ORONEO, votre assistant financier. Comment puis-je vous aider aujourd\'hui ?',
                colorScheme,
              ),
              
              // Message de l'utilisateur
              _buildUserMessage(
                'Je souhaite préparer ma retraite, quelles solutions me proposez-vous ?',
                colorScheme,
              ),
              
              // Message de l'IA
              _buildAIMessage(
                'Pour préparer votre retraite, je vous recommande d\'explorer le Plan d\'Épargne Retraite (PER). C\'est une solution qui vous permet de vous constituer une épargne tout en bénéficiant d\'avantages fiscaux.\n\nSouhaitez-vous en savoir plus sur le PER ou préférez-vous que nous réalisions une simulation personnalisée ?',
                colorScheme,
              ),
              
              // Message de l'utilisateur
              _buildUserMessage(
                'Je préfère une simulation personnalisée pour voir ce que ça donnerait dans mon cas.',
                colorScheme,
              ),
              
              // Message de l'IA
              _buildAIMessage(
                'Excellent choix ! Pour réaliser une simulation personnalisée, j\'aurai besoin de quelques informations :\n\n1. Votre âge actuel\n2. Votre revenu annuel\n3. L\'âge auquel vous souhaitez prendre votre retraite\n4. Le montant que vous pourriez épargner mensuellement\n\nPouvez-vous me communiquer ces informations ?',
                colorScheme,
              ),
            ],
          ),
        ),
        
        // Zone de saisie
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Écrivez votre message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: colorScheme.primary,
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: colorScheme.onPrimary,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildAIMessage(String text, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 64),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dans la méthode _buildAIMessage
          CircleAvatar(
            radius: 16,
            backgroundColor: colorScheme.primaryContainer,
            child: SvgPicture.asset(
              'assets/oroneo/logos/Odark.svg',
              height: 16,
              colorFilter: ColorFilter.mode(
                colorScheme.onPrimaryContainer,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUserMessage(String text, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: colorScheme.secondaryContainer,
            child: Text(
              'T',
              style: TextStyle(
                color: colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}