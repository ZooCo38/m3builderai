import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_controller.dart';

class WebPreview extends StatelessWidget {
  const WebPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    
    return Center(
      child: Container(
        width: 1024,
        height: 640,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Column(
            children: [
              // Navigation Bar
              Container(
                height: 64,
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.palette,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Material 3 Builder',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    _buildNavItem(context, 'Home', true),
                    _buildNavItem(context, 'Components', false),
                    _buildNavItem(context, 'Themes', false),
                    _buildNavItem(context, 'About', false),
                    const SizedBox(width: 16),
                    // Suppression du contrôle de thème qui crée un conflit
                    // avec celui dans home_view.dart
                    IconButton(
                      icon: const Icon(Icons.account_circle),
                      onPressed: () {},
                      tooltip: 'Account',
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: Row(
                  children: [
                    // Sidebar
                    Container(
                      width: 240,
                      color: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Navigation',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSidebarItem(context, 'Dashboard', Icons.dashboard, true),
                          _buildSidebarItem(context, 'Projects', Icons.folder, false),
                          _buildSidebarItem(context, 'Tasks', Icons.task, false),
                          _buildSidebarItem(context, 'Calendar', Icons.calendar_today, false),
                          _buildSidebarItem(context, 'Messages', Icons.message, false),
                          const Divider(),
                          Text(
                            'Settings',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSidebarItem(context, 'Account', Icons.person, false),
                          _buildSidebarItem(context, 'Preferences', Icons.settings, false),
                          _buildSidebarItem(context, 'Help', Icons.help, false),
                          const Spacer(),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: const Text('JD'),
                            ),
                            title: const Text('John Doe'),
                            subtitle: const Text('Administrator'),
                            dense: true,
                          ),
                        ],
                      ),
                    ),
                    
                    // Main Content
                    Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.background,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Stats Cards
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.people,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Users',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            '1,234',
                                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '+12% from last month',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Theme.of(context).colorScheme.secondary,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Orders',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            '567',
                                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '+5% from last month',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                color: Theme.of(context).colorScheme.tertiary,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Revenue',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            '\$12,345',
                                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '+18% from last month',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Recent Activity
                            Text(
                              'Recent Activity',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            Expanded(
                              child: Card(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                        child: Icon(
                                          Icons.person_add,
                                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                      title: const Text('New user registered'),
                                      subtitle: const Text('Jane Smith just created an account'),
                                      trailing: const Text('2 min ago'),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                        child: Icon(
                                          Icons.shopping_bag,
                                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        ),
                                      ),
                                      title: const Text('New order placed'),
                                      subtitle: const Text('Order #12345 was placed'),
                                      trailing: const Text('15 min ago'),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                                        child: Icon(
                                          Icons.comment,
                                          color: Theme.of(context).colorScheme.onTertiaryContainer,
                                        ),
                                      ),
                                      title: const Text('New comment'),
                                      subtitle: const Text('Bob commented on your post'),
                                      trailing: const Text('1 hour ago'),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                                        child: Icon(
                                          Icons.error,
                                          color: Theme.of(context).colorScheme.onErrorContainer,
                                        ),
                                      ),
                                      title: const Text('System alert'),
                                      subtitle: const Text('Server load is high'),
                                      trailing: const Text('2 hours ago'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Footer
              Container(
                height: 48,
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      '© 2023 Material 3 Builder',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Privacy Policy'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Terms of Service'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Contact Us'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context, String title, IconData icon, bool isActive) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isActive,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () {},
    );
  }
}