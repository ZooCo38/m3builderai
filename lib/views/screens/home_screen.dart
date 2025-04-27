import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              const Icon(Icons.menu),
              Text(
                'Title',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Icon(Icons.account_circle),
            ],
          ),
        ),
        
        // Content
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Card avec header
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header avec avatar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: colorScheme.primaryContainer,
                            child: Text('A', style: TextStyle(color: colorScheme.onPrimaryContainer)),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Header', style: Theme.of(context).textTheme.titleMedium),
                              Text('Subhead', style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.more_vert),
                        ],
                      ),
                    ),
                    // Media content
                    Container(
                      height: 200,
                      color: Colors.grey.shade300,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.change_history, size: 50, color: Colors.grey.shade500),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop_square, size: 40, color: Colors.grey.shade500),
                                const SizedBox(width: 30),
                                Icon(Icons.circle, size: 40, color: Colors.grey.shade500),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Card content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title', style: Theme.of(context).textTheme.titleMedium),
                          Text('Subtitle', style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 16),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: const Text('Enabled'),
                              ),
                              const SizedBox(width: 8),
                              FilledButton(
                                onPressed: () {},
                                child: const Text('Enabled'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Section title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text('Section title', style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    const Icon(Icons.arrow_right_alt),
                  ],
                ),
              ),
              
              // List item
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.change_history, color: Colors.grey.shade500, size: 20),
                ),
                title: Text('Title', style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
        ),
      ],
    );
  }
}