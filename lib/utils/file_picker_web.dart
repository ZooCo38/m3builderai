import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

/// Classe utilitaire pour gérer la sélection de fichiers sur le web
class FilePickerWeb {
  /// Sélectionne un fichier et retourne son contenu sous forme de chaîne
  static Future<String?> pickFile({List<String>? allowedExtensions}) async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = allowedExtensions?.map((ext) => '.$ext').join(',') ?? '';
    uploadInput.click();

    await uploadInput.onChange.first;
    if (uploadInput.files!.isEmpty) return null;

    final file = uploadInput.files![0];
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;

    final Uint8List bytes = reader.result as Uint8List;
    return utf8.decode(bytes);
  }

  /// Télécharge un fichier avec le contenu spécifié
  static void downloadFile(String content, String fileName) {
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..style.display = 'none';
    
    html.document.body?.children.add(anchor);
    anchor.click();
    
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}