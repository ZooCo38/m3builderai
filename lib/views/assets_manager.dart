import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_controller.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle, ByteData;

class AssetFolder {
  final String name;
  final String path;
  final List<AssetItem> assets;

  AssetFolder({
    required this.name,
    required this.path,
    required this.assets,
  });
}

class AssetItem {
  final String name;
  final String path;
  final bool isDirectory;
  final String? thumbnailPath;

  AssetItem({
    required this.name,
    required this.path,
    required this.isDirectory,
    this.thumbnailPath,
  });
}

class AssetsManager extends StatefulWidget {
  const AssetsManager({Key? key}) : super(key: key);

  @override
  State<AssetsManager> createState() => _AssetsManagerState();
}

class _AssetsManagerState extends State<AssetsManager> {
  bool _isLoading = false;
  String _statusMessage = '';
  List<AssetFolder> _assetFolders = [];

  @override
  void initState() {
    super.initState();
    _loadAssetFolders();
  }

  Future<void> _loadAssetFolders() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Chargement des assets...';
    });

    try {
      // Créer manuellement la structure des dossiers et assets
      final List<AssetFolder> folders = [];
      
      // Dossier Logos
      final logosFolder = AssetFolder(
        name: 'Logos',
        path: 'assets/oroneo/logos',
        assets: [
          AssetItem(
            name: 'Logodark.svg',
            path: 'assets/oroneo/logos/Logodark.svg',
            isDirectory: false,
            thumbnailPath: 'assets/oroneo/logos/Logodark.svg',
          ),
          AssetItem(
            name: 'Logolight.svg',
            path: 'assets/oroneo/logos/Logolight.svg',
            isDirectory: false,
            thumbnailPath: 'assets/oroneo/logos/Logolight.svg',
          ),
          AssetItem(
            name: 'Odark.svg',
            path: 'assets/oroneo/logos/Odark.svg',
            isDirectory: false,
            thumbnailPath: 'assets/oroneo/logos/Odark.svg',
          ),
          AssetItem(
            name: 'Ogrey.svg',
            path: 'assets/oroneo/logos/Ogrey.svg',
            isDirectory: false,
            thumbnailPath: 'assets/oroneo/logos/Ogrey.svg',
          ),
          AssetItem(
            name: 'Olight.svg',
            path: 'assets/oroneo/logos/Olight.svg',
            isDirectory: false,
            thumbnailPath: 'assets/oroneo/logos/Olight.svg',
          ),
        ],
      );
      folders.add(logosFolder);
      
      // Dossier Images
      final imagesFolder = AssetFolder(
        name: 'Images',
        path: 'assets/oroneo/images',
        assets: [
          AssetItem(
            name: 'couple_accueil.png',
            path: 'assets/oroneo/images/couple_accueil.png',
            isDirectory: false,
            thumbnailPath: 'assets/oroneo/images/couple_accueil.png',
          ),
        ],
      );
      folders.add(imagesFolder);
      
      // Dossier Icons (vide pour l'instant)
      final iconsFolder = AssetFolder(
        name: 'Icons',
        path: 'assets/oroneo/icons',
        assets: [],
      );
      folders.add(iconsFolder);
      
      // Dossier Fonts (vide pour l'instant)
      final fontsFolder = AssetFolder(
        name: 'Fonts',
        path: 'assets/oroneo/fonts',
        assets: [],
      );
      folders.add(fontsFolder);
      
      // Dossier Carousel (vide pour l'instant)
      final carouselFolder = AssetFolder(
        name: 'Carousel',
        path: 'assets/oroneo/carousel',
        assets: [],
      );
      folders.add(carouselFolder);

      setState(() {
        _assetFolders = folders;
        _isLoading = false;
        _statusMessage = 'Assets chargés: ${folders.length} dossiers';
      });
    } catch (e) {
      print('Erreur générale: $e');
      setState(() {
        _isLoading = false;
        _statusMessage = 'Erreur lors du chargement des assets: $e';
      });
    }
  }

  Future<void> _downloadAsset(AssetItem asset) async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Préparation du téléchargement de ${asset.name}...';
    });

    try {
      // Pour le web, nous devons utiliser une approche différente
      if (kIsWeb) {
        // Créer un lien de téléchargement pour le web
        try {
          print('Tentative de téléchargement web pour: ${asset.path}');
          
          // Pour les SVG, nous pouvons créer un blob à partir du contenu SVG
          if (asset.path.endsWith('.svg')) {
            // Utiliser une approche HTML pour le téléchargement
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pour télécharger ce SVG, faites un clic droit sur l\'image et sélectionnez "Enregistrer l\'image sous..."'),
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 5),
              ),
            );
          } else if (['.png', '.jpg', '.jpeg', '.gif', '.webp'].contains(path.extension(asset.path).toLowerCase())) {
            // Pour les images, suggérer le clic droit
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pour télécharger cette image, faites un clic droit sur l\'image et sélectionnez "Enregistrer l\'image sous..."'),
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 5),
              ),
            );
          } else {
            // Pour les autres types de fichiers
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Le téléchargement direct de ${asset.name} n\'est pas disponible sur le web.'),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 3),
              ),
            );
          }
          
          setState(() {
            _isLoading = false;
            _statusMessage = 'Utilisez le clic droit pour télécharger ${asset.name}';
          });
          return;
        } catch (e) {
          print('Erreur lors du téléchargement web: $e');
          setState(() {
            _isLoading = false;
            _statusMessage = 'Erreur lors du téléchargement: $e';
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: $e'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          return;
        }
      }
      
      // Pour les plateformes natives (code existant pour les environnements non-web)
      try {
        // Ajouter un log pour déboguer
        print('Tentative de téléchargement de l\'asset: ${asset.path}');
        
        // Obtenir le répertoire de téléchargement
        final directory = await getApplicationDocumentsDirectory();
        final downloadPath = directory.path;
        final localPath = path.join(downloadPath, asset.name);
        
        print('Chemin de téléchargement: $localPath');
        
        // Créer le fichier local
        final file = io.File(localPath);
        
        // Pour les SVG, nous pouvons utiliser une approche différente
        if (asset.path.endsWith('.svg')) {
          // Essayer de lire le contenu du SVG depuis les assets
          try {
            final String svgContent = await rootBundle.loadString(asset.path);
            await file.writeAsString(svgContent);
            
            setState(() {
              _isLoading = false;
              _statusMessage = 'SVG téléchargé à $localPath';
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('SVG téléchargé: ${asset.name} dans $downloadPath'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );
            return;
          } catch (e) {
            print('Erreur lors du chargement du SVG depuis les assets: $e');
            // Créer un SVG de remplacement
            final svgContent = '''
<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
  <rect width="200" height="200" fill="#f0f0f0"/>
  <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-family="Arial" font-size="16">
    ${asset.name}
  </text>
</svg>
''';
            await file.writeAsString(svgContent);
            
            setState(() {
              _isLoading = false;
              _statusMessage = 'SVG de remplacement créé à $localPath';
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('SVG de remplacement créé pour ${asset.name} dans $downloadPath'),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 3),
              ),
            );
            return;
          }
        }
        
        // Pour les images, essayer de les copier depuis les assets
        if (['.png', '.jpg', '.jpeg', '.gif', '.webp'].contains(path.extension(asset.path).toLowerCase())) {
          try {
            final ByteData data = await rootBundle.load(asset.path);
            final bytes = data.buffer.asUint8List();
            await file.writeAsBytes(bytes);
            
            setState(() {
              _isLoading = false;
              _statusMessage = 'Image téléchargée à $localPath';
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Image téléchargée: ${asset.name} dans $downloadPath'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );
            return;
          } catch (e) {
            print('Erreur lors du chargement de l\'image depuis les assets: $e');
            // Créer une image de remplacement
            final List<int> bytes = List<int>.filled(100 * 100 * 4, 255); // RGBA blanc
            await file.writeAsBytes(bytes);
            
            setState(() {
              _isLoading = false;
              _statusMessage = 'Image de remplacement créée à $localPath';
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Image de remplacement créée pour ${asset.name} dans $downloadPath'),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 3),
              ),
            );
            return;
          }
        }
        
        // Pour les autres types de fichiers
        await file.writeAsString('Contenu de test pour ${asset.name}');
        
        setState(() {
          _isLoading = false;
          _statusMessage = 'Fichier créé à $localPath';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fichier créé pour ${asset.name} dans $downloadPath'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      } catch (e) {
        print('Erreur lors du téléchargement: $e');
        setState(() {
          _isLoading = false;
          _statusMessage = 'Erreur lors du téléchargement: $e';
        });
        
        // Afficher une snackbar d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: Impossible de télécharger ${asset.name} - $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Erreur lors du téléchargement: $e';
      });
      
      // Afficher une snackbar d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;

    return DefaultTabController(
      length: 4, // Nombre d'onglets
      child: Scaffold(
        backgroundColor: currentTheme.colorScheme.background,
        appBar: AppBar(
          title: const Text('Gestionnaire d\'Assets ORONEO'),
          backgroundColor: currentTheme.colorScheme.surface,
          foregroundColor: currentTheme.colorScheme.onSurface,
        ),
        body: Column(
          children: [
            // Barre d'onglets pour les catégories d'assets
            Container(
              color: currentTheme.colorScheme.surface,
              child: TabBar(
                tabs: [
                  Tab(text: 'Logos', icon: Icon(Icons.branding_watermark)),
                  Tab(text: 'Images', icon: Icon(Icons.image)),
                  Tab(text: 'Icônes', icon: Icon(Icons.emoji_emotions)),
                  Tab(text: 'Fonts', icon: Icon(Icons.text_fields)),
                ],
                labelColor: currentTheme.colorScheme.primary,
                unselectedLabelColor: currentTheme.colorScheme.onSurfaceVariant,
                indicatorColor: currentTheme.colorScheme.primary,
              ),
            ),
            
            // Message d'information pour le téléchargement
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: currentTheme.colorScheme.primaryContainer,
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: currentTheme.colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pour télécharger un asset, faites un clic droit sur l\'image puis sélectionnez "Enregistrer l\'image sous..."',
                      style: TextStyle(
                        color: currentTheme.colorScheme.onPrimaryContainer,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Contenu des onglets
            Expanded(
              child: TabBarView(
                children: [
                  // Onglet Logos
                  _buildAssetGrid(_assetFolders.firstWhere((f) => f.name == 'Logos', orElse: () => AssetFolder(name: 'Logos', path: '', assets: [])), currentTheme),
                  
                  // Onglet Images
                  _buildAssetGrid(_assetFolders.firstWhere((f) => f.name == 'Images', orElse: () => AssetFolder(name: 'Images', path: '', assets: [])), currentTheme),
                  
                  // Onglet Icônes
                  _buildAssetGrid(_assetFolders.firstWhere((f) => f.name == 'Icons', orElse: () => AssetFolder(name: 'Icons', path: '', assets: [])), currentTheme),
                  
                  // Onglet Fonts
                  _buildAssetGrid(_assetFolders.firstWhere((f) => f.name == 'Fonts', orElse: () => AssetFolder(name: 'Fonts', path: '', assets: [])), currentTheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAssetGrid(AssetFolder folder, ThemeData currentTheme) {
    if (folder.assets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_off,
              size: 64,
              color: currentTheme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun asset trouvé dans ${folder.name}',
              style: currentTheme.textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }
    
    return Container(
      color: currentTheme.colorScheme.surfaceVariant,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.6, // Réduction de la hauteur des cartes (valeur plus grande = cartes plus plates)
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: folder.assets.length,
        itemBuilder: (context, index) {
          final asset = folder.assets[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: InkWell(
              onTap: () {
                // Afficher une boîte de dialogue avec le nom du fichier et des instructions
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Télécharger ${asset.name}'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pour télécharger cet asset:'),
                        const SizedBox(height: 8),
                        Text('1. Faites un clic droit sur l\'image ci-dessous'),
                        Text('2. Sélectionnez "Enregistrer l\'image sous..."'),
                        Text('3. Nommez le fichier: ${asset.name}'),
                        const SizedBox(height: 16),
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: currentTheme.colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: _buildAssetPreview(asset),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Fermer'),
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Aperçu de l'asset
                  Expanded(
                    child: Container(
                      color: currentTheme.colorScheme.surfaceContainer,
                      child: Center(
                        child: _buildAssetPreview(asset),
                      ),
                    ),
                  ),
                  
                  // Informations de l'asset avec nom et indication
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: currentTheme.colorScheme.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          asset.name,
                          style: currentTheme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Cliquer pour détails',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTheme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAssetPreview(AssetItem asset) {
    final extension = path.extension(asset.path).toLowerCase();
    
    if (extension == '.svg') {
      try {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            asset.path,
            fit: BoxFit.contain, // Utiliser contain pour respecter le ratio
            placeholderBuilder: (context) => const Icon(Icons.image, size: 48),
          ),
        );
      } catch (e) {
        print('Erreur lors du chargement du SVG: $e');
        return const Icon(Icons.broken_image, size: 48);
      }
    } else if (['.png', '.jpg', '.jpeg', '.gif', '.webp'].contains(extension)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          asset.path,
          fit: BoxFit.contain, // Utiliser contain pour respecter le ratio
          errorBuilder: (context, error, stackTrace) {
            print('Erreur lors du chargement de l\'image: $error');
            return const Icon(Icons.broken_image, size: 48);
          },
        ),
      );
    } else if (['.ttf', '.otf'].contains(extension) || asset.path.contains('fonts')) {
      // Affichage spécial pour les polices
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.text_fields,
            size: 36,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 4),
          Text(
            'Aa Bb Cc',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
    
    // Icônes par défaut selon le type de fichier
    IconData iconData;
    Color iconColor = Colors.grey[700]!;
    String? subtitle;
    
    switch (extension) {
      case '.pdf':
        iconData = Icons.picture_as_pdf;
        iconColor = Colors.red[700]!;
        subtitle = 'PDF';
        break;
      case '.doc':
      case '.docx':
        iconData = Icons.description;
        iconColor = Colors.blue[700]!;
        subtitle = 'DOC';
        break;
      case '.xls':
      case '.xlsx':
        iconData = Icons.table_chart;
        iconColor = Colors.green[700]!;
        subtitle = 'XLS';
        break;
      case '.txt':
        iconData = Icons.text_snippet;
        subtitle = 'TXT';
        break;
      case '.json':
        iconData = Icons.data_object;
        iconColor = Colors.amber[700]!;
        subtitle = 'JSON';
        break;
      case '.css':
        iconData = Icons.css;
        iconColor = Colors.blue[700]!;
        subtitle = 'CSS';
        break;
      case '.html':
        iconData = Icons.html;
        iconColor = Colors.orange[700]!;
        subtitle = 'HTML';
        break;
      default:
        iconData = Icons.insert_drive_file;
        subtitle = extension.isNotEmpty ? extension.substring(1).toUpperCase() : 'FILE';
    }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 36, color: iconColor),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ),
      ],
    );
  }
}