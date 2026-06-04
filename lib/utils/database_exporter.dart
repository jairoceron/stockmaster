import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DatabaseExporter {
  /// Exporta y comparte la base de datos SQLite usando share_plus
  static Future<void> exportAndShare() async {
    try {
      // Carpeta app_flutter
      final dir = await getApplicationDocumentsDirectory();
      final sourceFile = File(p.join(dir.path, 'app.sqlite'));

      if (await sourceFile.exists()) {
        await Share.shareXFiles([XFile(sourceFile.path)],
            text: 'Aquí está mi base de datos SQLite exportada.');
      } else {
        throw Exception('No se encontró el archivo app.sqlite');
      }
    } catch (e) {
      rethrow;
    }
  }
}

