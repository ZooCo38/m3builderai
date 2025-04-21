import 'package:flutter/material.dart';

class MobilePreview extends StatefulWidget {
  const MobilePreview({super.key});

  @override
  State<MobilePreview> createState() => _MobilePreviewState();
}

class _MobilePreviewState extends State<MobilePreview> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Utiliser les couleurs du thème actuel
    final colorScheme = Theme.of(context).colorScheme;
    
    return Center(
      child: Container(
        width: 380, // Ajusté à 380px
        height: 844, // Ajusté à 844px pour correspondre au ratio d'un téléphone moderne
        decoration: BoxDecoration(
          color: colorScheme.background, // Utiliser la couleur de fond du thème au lieu de noir
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.black,
            width: 10,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              // Status Bar
              Container(
                height: 30, // Légèrement plus grand pour les téléphones modernes
                color: colorScheme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:30',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 12),
                        const SizedBox(width: 8),
                        const Icon(Icons.signal_cellular_4_bar, size: 16),
                        const SizedBox(width: 4),
                        const Icon(Icons.wifi, size: 16),
                        const SizedBox(width: 4),
                        const Icon(Icons.battery_full, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Contenu principal qui change en fonction de l'index
              Expanded(
                child: _buildScreen(_currentIndex),
              ),
              
              // Bottom Navigation Bar
              Container(
                height: 80,
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: _currentIndex == 0 
                                ? colorScheme.primaryContainer 
                                : colorScheme.surfaceVariant,
                            radius: 20,
                            child: Icon(
                              Icons.home,
                              color: _currentIndex == 0 
                                  ? colorScheme.onPrimaryContainer 
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: _currentIndex == 0 
                                  ? colorScheme.primary 
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: _currentIndex == 1 
                                ? colorScheme.primaryContainer 
                                : colorScheme.surfaceVariant,
                            radius: 20,
                            child: Icon(
                              Icons.message, // Utiliser l'icône message qui est plus fiable
                              color: _currentIndex == 1 
                                  ? colorScheme.onPrimaryContainer 
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Discuter',
                            style: TextStyle(
                              color: _currentIndex == 1 
                                  ? colorScheme.primary 
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: _currentIndex == 2 
                                ? colorScheme.primaryContainer 
                                : colorScheme.surfaceVariant,
                            radius: 20,
                            child: Icon(
                              Icons.account_circle,
                              color: _currentIndex == 2 
                                  ? colorScheme.onPrimaryContainer 
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Mon profil',
                            style: TextStyle(
                              color: _currentIndex == 2 
                                  ? colorScheme.primary 
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Home indicator
              Container(
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildChatScreen();
      case 2:
        return _buildProfileScreen();
      default:
        return _buildHomeScreen();
    }
  }
  
  Widget _buildHomeScreen() {
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
  
  Widget _buildChatScreen() {
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
  
  Widget _buildProfileScreen() {
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
                'Profil',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Icon(Icons.edit),
            ],
          ),
        ),
        
        // Profile content
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Header avec photo de profil
              Container(
                color: colorScheme.primaryContainer,
                padding: const EdgeInsets.only(top: 32, bottom: 24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.primary,
                      child: Text(
                        'JD',
                        style: TextStyle(
                          fontSize: 32,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@example.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Statistiques
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn('Posts', '24'),
                    _buildStatColumn('Followers', '482'),
                    _buildStatColumn('Following', '128'),
                  ],
                ),
              ),
              
              const Divider(),
              
              // Sections
              ListTile(
                leading: Icon(Icons.settings, color: colorScheme.primary),
                title: const Text('Paramètres'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: colorScheme.primary),
                title: const Text('Confidentialité'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.help, color: colorScheme.primary),
                title: const Text('Aide et support'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.logout, color: colorScheme.primary),
                title: const Text('Déconnexion'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatColumn(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}