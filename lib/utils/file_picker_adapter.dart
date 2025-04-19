import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';

/// Classe adaptateur pour le package file_picker qui fonctionne sur le web et les plateformes natives
class FilePickerAdapter {
  /// Sélectionne un fichier et retourne son contenu sous forme de chaîne
  static Future<FilePickerResult?> pickFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool withData = true,
  }) async {
    try {
      return await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        withData: withData,
      );
    } catch (e) {
      print('Erreur lors de la sélection de fichier: $e');
      return null;
    }
  }

  /// Extrait le contenu d'un fichier à partir d'un FilePickerResult
  static String? getFileContent(FilePickerResult result) {
    try {
      final bytes = result.files.single.bytes;
      if (bytes != null) {
        return utf8.decode(bytes);
      }
      return null;
    } catch (e) {
      print('Erreur lors de l\'extraction du contenu du fichier: $e');
      return null;
    }
  }
}