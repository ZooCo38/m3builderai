import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_controller.dart';

class AdditionalComponentsView extends StatefulWidget {
  const AdditionalComponentsView({Key? key}) : super(key: key);

  @override
  State<AdditionalComponentsView> createState() => _AdditionalComponentsViewState();
}

class _AdditionalComponentsViewState extends State<AdditionalComponentsView> with TickerProviderStateMixin {
  bool _switchValue = true;
  double _sliderValue = 0.5;
  int _radioValue = 0;
  bool _checkboxValue = true;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _textController = TextEditingController(text: "Texte d'exemple");
  late TabController _tabController;
  final List<String> _tabs = ['Tab 1', 'Tab 2', 'Tab 3'];
  bool _showSearchBar = false;
  final List<String> _chipOptions = ['Option 1', 'Option 2', 'Option 3'];
  final Set<String> _selectedChips = {'Option 1'};
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = Theme.of(context);
    
    // Fonction pour créer un widget cliquable qui met à jour la sélection
    Widget selectableComponent(Widget child, String name, List<String> colorProperties, {String? description}) {
      final isSelected = themeController.selectedComponentInfo?.componentName == name;
      
      return InkWell(
        onTap: () {
          themeController.setSelectedComponent(name, colorProperties);
        },
        child: Container(
          width: 200, // Largeur fixe pour une meilleure disposition
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: currentTheme.colorScheme.primary, width: 2)
                : Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
            color: currentTheme.colorScheme.surface,
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: child),
              const SizedBox(height: 12),
              Text(name, 
                style: currentTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    description,
                    style: currentTheme.textTheme.bodySmall,
                  ),
                ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: colorProperties.map((prop) => 
                  Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    label: Text(prop, style: const TextStyle(fontSize: 10)),
                    backgroundColor: currentTheme.colorScheme.surfaceVariant,
                    padding: EdgeInsets.zero,
                  )
                ).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.start,
        children: [
          // Floating Action Buttons - Small
          selectableComponent(
            FloatingActionButton.small(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            'Small FAB',
            ['primary', 'onPrimary', 'primaryContainer', 'surface', 'elevation'],
            description: 'Utilise primary pour le fond et onPrimary pour l\'icône',
          ),
          
          // Floating Action Buttons - Standard
          selectableComponent(
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            'Floating Action Button',
            ['primary', 'onPrimary', 'primaryContainer', 'surface', 'elevation'],
            description: 'Utilise primary pour le fond et onPrimary pour l\'icône',
          ),
          
          // Floating Action Buttons - Large
          selectableComponent(
            FloatingActionButton.large(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            'Large FAB',
            ['primary', 'onPrimary', 'primaryContainer', 'surface', 'elevation'],
            description: 'Utilise primary pour le fond et onPrimary pour l\'icône',
          ),
          
          selectableComponent(
            FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Extended FAB'),
            ),
            'Extended FAB',
            ['primary', 'onPrimary', 'primaryContainer', 'surface', 'elevation'],
            description: 'Utilise primary pour le fond et onPrimary pour le texte et l\'icône',
          ),
          
          // Icon Buttons
          selectableComponent(
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            'Icon Button',
            ['onSurface', 'primary', 'primaryContainer'],
            description: 'Utilise onSurface ou primary pour l\'icône',
          ),
          
          // Filled Icon Button
          selectableComponent(
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            'Filled Icon Button',
            ['primary', 'onPrimary', 'primaryContainer'],
            description: 'Utilise primary pour le fond et onPrimary pour l\'icône',
          ),
          
          // Filled Tonal Icon Button
          selectableComponent(
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            'Filled Tonal Icon Button',
            ['secondaryContainer', 'onSecondaryContainer', 'secondary'],
            description: 'Utilise secondaryContainer pour le fond et onSecondaryContainer pour l\'icône',
          ),
          
          // Outlined Icon Button
          selectableComponent(
            IconButton.outlined(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            'Outlined Icon Button',
            ['outline', 'primary', 'onSurface'],
            description: 'Utilise outline pour la bordure et primary pour l\'icône',
          ),
          
          // Segmented Buttons
          selectableComponent(
            SizedBox(
              width: 180,
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment<int>(value: 0, label: Text('Option 1')),
                  ButtonSegment<int>(value: 1, label: Text('Option 2')),
                ],
                selected: {0},
                onSelectionChanged: (Set<int> newSelection) {},
              ),
            ),
            'Segmented Button',
            ['outline', 'primary', 'onPrimary', 'secondaryContainer', 'onSecondaryContainer'],
            description: 'Utilise outline pour la bordure, primary pour le texte non sélectionné, et secondaryContainer pour le fond sélectionné',
          ),
          
          // Badges
          selectableComponent(
            Badge(
              label: const Text('3'),
              child: const Icon(Icons.notifications, size: 30),
            ),
            'Badge',
            ['error', 'onError'],
            description: 'Utilise error pour le fond et onError pour le texte',
          ),
          
          // Progress Indicators
          selectableComponent(
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
            'Circular Progress',
            ['primary', 'primaryContainer', 'surface'],
            description: 'Utilise primary pour l\'indicateur',
          ),
          
          selectableComponent(
            const LinearProgressIndicator(),
            'Linear Progress',
            ['primary', 'primaryContainer', 'surface'],
            description: 'Utilise primary pour l\'indicateur et primaryContainer pour le fond',
          ),
          
          // Snackbar
          selectableComponent(
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Ceci est un Snackbar'),
                    action: SnackBarAction(
                      label: 'Action',
                      onPressed: () {},
                    ),
                  ),
                );
              },
              child: const Text('Afficher Snackbar'),
            ),
            'Snackbar',
            ['inverseSurface', 'onInverseSurface', 'primary'],
            description: 'Utilise inverseSurface pour le fond et onInverseSurface pour le texte',
          ),
          
          // Carousel
          selectableComponent(
            SizedBox(
              height: 100,
              width: 150,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(
                      child: Text('Slide ${index + 1}'),
                    ),
                  );
                },
              ),
            ),
            'Carousel',
            ['surface', 'onSurface', 'elevation'],
            description: 'Utilise surface pour le fond des cartes et onSurface pour le texte',
          ),
          
          // Navigation Drawer
          selectableComponent(
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => NavigationDrawer(
                    children: [
                      const DrawerHeader(
                        child: Text('Drawer Header'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Accueil'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Navigation Drawer'),
            ),
            'Navigation Drawer',
            ['surface', 'onSurface', 'primary', 'surfaceVariant'],
            description: 'Utilise surface pour le fond et onSurface pour le texte',
          ),
          
          // Navigation Rail
          selectableComponent(
            SizedBox(
              height: 100,
              width: 150,
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: 0,
                    onDestinationSelected: (int index) {},
                    labelType: NavigationRailLabelType.selected,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: Text('Accueil'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite_outline),
                        selectedIcon: Icon(Icons.favorite),
                        label: Text('Favoris'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            'Navigation Rail',
            ['surface', 'onSurface', 'primary', 'onPrimary', 'secondaryContainer', 'onSecondaryContainer'],
            description: 'Utilise surface pour le fond, onSurface pour les icônes non sélectionnées, et primary pour les éléments sélectionnés',
          ),
          
          // Tabs
          selectableComponent(
            SizedBox(
              width: 150,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                  ),
                ],
              ),
            ),
            'Tabs',
            ['primary', 'onPrimary', 'surfaceVariant', 'onSurfaceVariant'],
            description: 'Utilise primary pour l\'indicateur et onSurfaceVariant pour le texte',
          ),
          
          // Search
          selectableComponent(
            SizedBox(
              width: 150,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Rechercher...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            'Search',
            ['primary', 'onSurface', 'outline', 'surfaceVariant'],
            description: 'Utilise primary pour la mise en évidence, onSurface pour le texte',
          ),
          
          // Selection Checkboxes
          selectableComponent(
            CheckboxListTile(
              title: const Text('Option'),
              value: _checkboxValue,
              onChanged: (bool? value) {},
            ),
            'Checkbox',
            ['primary', 'onSurface', 'surface'],
            description: 'Utilise primary pour la case cochée et onSurface pour le texte',
          ),
          
          // Selection Chips
          selectableComponent(
            Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: const Text('Option'),
                  selected: true,
                  onSelected: (bool selected) {},
                ),
              ],
            ),
            'Filter Chip',
            ['primary', 'onPrimary', 'surfaceVariant', 'onSurfaceVariant'],
            description: 'Utilise surfaceVariant pour le fond non sélectionné et primary pour le fond sélectionné',
          ),
          
          // Date Picker
          selectableComponent(
            ElevatedButton(
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
              },
              child: const Text('Date Picker'),
            ),
            'Date Picker',
            ['surface', 'onSurface', 'primary', 'surfaceVariant'],
            description: 'Utilise surface pour le fond et primary pour la sélection',
          ),
          
          // Time Picker
          selectableComponent(
            ElevatedButton(
              onPressed: () async {
                await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
              },
              child: const Text('Time Picker'),
            ),
            'Time Picker',
            ['surface', 'onSurface', 'primary', 'surfaceVariant'],
            description: 'Utilise surface pour le fond et primary pour la sélection',
          ),
          
          // Menu
          selectableComponent(
            PopupMenuButton<String>(
              onSelected: (String value) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'option1',
                  child: Text('Option 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'option2',
                  child: Text('Option 2'),
                ),
              ],
              child: const ElevatedButton(
                onPressed: null,
                child: Text('Menu'),
              ),
            ),
            'Menu',
            ['surface', 'onSurface', 'surfaceVariant'],
            description: 'Utilise surface pour le fond et onSurface pour le texte',
          ),
          
          // Radio Buttons
          selectableComponent(
            RadioListTile<int>(
              title: const Text('Option'),
              value: 0,
              groupValue: _radioValue,
              onChanged: (int? newValue) {},
            ),
            'Radio Button',
            ['primary', 'onSurface', 'surface'],
            description: 'Utilise primary pour le bouton sélectionné et onSurface pour le texte',
          ),
          
          // Sliders
          selectableComponent(
            Slider(
              value: _sliderValue,
              onChanged: (double value) {},
            ),
            'Slider',
            ['primary', 'primaryContainer', 'surfaceVariant'],
            description: 'Utilise primary pour le curseur et primaryContainer pour la piste active',
          ),
          
          // Switches
          selectableComponent(
            Switch(
              value: _switchValue,
              onChanged: (bool value) {},
            ),
            'Switch',
            ['primary', 'onPrimary', 'surfaceVariant', 'onSurface', 'outline'],
            description: 'Utilise primary pour l\'interrupteur activé et surfaceVariant pour la piste',
          ),
          
          // Text Fields
          selectableComponent(
            SizedBox(
              width: 150,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Champ de texte',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            'Text Field',
            ['primary', 'onSurface', 'outline', 'surfaceVariant'],
            description: 'Utilise primary pour la mise en évidence, onSurface pour le texte et outline pour la bordure',
          ),
        ],
      ),
    );
  }
}