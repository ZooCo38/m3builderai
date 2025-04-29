import 'package:flutter/material.dart';

class OroneoChatScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const OroneoChatScreen({
    Key? key,
    this.onBackToHome,
  }) : super(key: key);

  @override
  State<OroneoChatScreen> createState() => _OroneoChatScreenState();
}

class _OroneoChatScreenState extends State<OroneoChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Ajouter des messages de démonstration
    _addDemoMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addDemoMessages() {
    // Simuler une conversation sur la retraite
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Bonjour ! Je suis votre assistant Oroneo. Comment puis-je vous aider aujourd'hui ?",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
        );
      });
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Je voudrais des informations sur ma retraite.",
            isUser: true,
            timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
          ),
        );
      });
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isTyping = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: "Bien sûr ! Pour vous aider au mieux concernant votre retraite, j'aurais besoin de quelques informations :\n\n"
                "1. Quel âge avez-vous actuellement ?\n"
                "2. Depuis combien d'années travaillez-vous ?\n"
                "3. Quel est votre statut professionnel (salarié, indépendant, fonctionnaire) ?",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
          ),
        );
      });
    });

    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "J'ai 45 ans, je travaille depuis 20 ans comme salarié dans le secteur privé.",
            isUser: true,
            timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
          ),
        );
      });
    });

    Future.delayed(const Duration(milliseconds: 4500), () {
      setState(() {
        _isTyping = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 6000), () {
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: "Merci pour ces informations. Voici une estimation pour votre retraite :\n\n"
                "À 45 ans avec 20 ans d'activité comme salarié du privé, vous avez accumulé environ 80 trimestres sur les 172 nécessaires pour une retraite à taux plein.\n\n"
                "Si vous continuez à travailler sans interruption, vous pourriez prendre votre retraite à taux plein vers 67 ans.\n\n"
                "Votre pension estimée serait d'environ 60% de votre salaire moyen des 25 meilleures années.\n\n"
                "Souhaitez-vous explorer des solutions pour améliorer votre future pension de retraite ?",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
          ),
        );
      });
      
      // Faire défiler vers le bas après l'ajout des messages
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    
    _messageController.clear();
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });
    
    // Faire défiler vers le bas
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
    
    // Simuler la réponse de l'IA
    setState(() {
      _isTyping = true;
    });
    
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: "Oui, je peux vous aider à explorer des solutions pour améliorer votre retraite. Voici quelques options :\n\n"
                "1. **Épargne retraite complémentaire** : PER (Plan d'Épargne Retraite) individuel ou d'entreprise\n"
                "2. **Investissement immobilier** : acquisition de biens locatifs\n"
                "3. **Assurance-vie** : placement à long terme avec avantages fiscaux\n"
                "4. **Rachat de trimestres** : pour compléter vos droits\n\n"
                "Quelle option vous intéresse le plus ?",
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      
      // Faire défiler vers le bas après la réponse
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              radius: 16,
              child: Icon(
                Icons.smart_toy,
                size: 18,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Assistant Oroneo'),
          ],
        ),
        leading: widget.onBackToHome != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBackToHome,
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Liste des messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message, theme);
              },
            ),
          ),
          
          // Indicateur de frappe
          if (_isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    radius: 16,
                    child: Icon(
                      Icons.smart_toy,
                      size: 18,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Assistant est en train d'écrire..."),
                ],
              ),
            ),
          
          // Séparateur
          Divider(height: 1, color: theme.colorScheme.outline),
          
          // Zone de saisie
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: theme.colorScheme.surface,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    _showAttachmentOptions(context);
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Posez votre question...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: _handleSubmitted,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Implémenter la reconnaissance vocale
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reconnaissance vocale non disponible')),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _handleSubmitted(_messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text('Enregistrer la conversation'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Conversation enregistrée')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Partager la conversation'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fonctionnalité de partage non disponible')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Effacer la conversation'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Effacer la conversation'),
          content: const Text('Êtes-vous sûr de vouloir effacer toute la conversation ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _messages.clear();
                  _addDemoMessages();
                });
              },
              child: const Text('Effacer'),
            ),
          ],
        );
      },
    );
  }
  
  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Photo'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fonctionnalité non disponible')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Caméra'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fonctionnalité non disponible')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text('Document'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fonctionnalité non disponible')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildMessage(ChatMessage message, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              radius: 16,
              child: Icon(
                Icons.smart_toy,
                size: 18,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: message.isUser 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser 
                          ? theme.colorScheme.onPrimary 
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isUser 
                          ? theme.colorScheme.onPrimary.withOpacity(0.7) 
                          : theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: theme.colorScheme.secondaryContainer,
              radius: 16,
              child: Icon(
                Icons.person,
                size: 18,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}