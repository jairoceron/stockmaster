import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<void> resetDatabase() async {
  // Obtiene el directorio de documentos de la app
  final dir = await getApplicationDocumentsDirectory();
  final dbPath = p.join(dir.path, 'app.sqlite');

  final file = File(dbPath);
  if (await file.exists()) {
    await file.delete();
    print("✅ Base de datos borrada: $dbPath");
  } else {
    print("ℹ️ No había base de datos en: $dbPath");
  }
}
