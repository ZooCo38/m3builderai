import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        // App Bar
        Container(
          height: 56,
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back),
              Text(
                'Chat',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Icon(Icons.more_vert),
            ],
          ),
        ),
        
        // Chat content
        Expanded(
          child: Container(
            color: colorScheme.background,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Message reçu
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bonjour, comment ça va ?',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '09:15',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Message envoyé
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Très bien, merci ! Et toi ?',
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '09:17',
                          style: TextStyle(
                            color: colorScheme.onPrimary.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Message reçu
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ça va bien aussi ! Tu as prévu quelque chose aujourd\'hui ?',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '09:20',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Input field
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: colorScheme.surface,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceVariant.withOpacity(0.5),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}