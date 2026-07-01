import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmaster/data/database/local/images_stockmaster_dao.dart';
import '../data/database/local/app_database.dart';

import 'package:stockmaster/state/image_stockmaster_notifier.dart';
import '/models/image_stockmaster.dart';

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

/// Helper para resolver cualquier tipo de imagen
Future<pw.ImageProvider?> resolveImage(String? path) async {
  if (path == null || path.isEmpty) return null;

  try {
    // Caso 1: Asset (ej. "assets/images/miel.png")
    if (path.startsWith("assets/")) {
      final bytes = await rootBundle.load(path);
      return pw.MemoryImage(bytes.buffer.asUint8List());
    }

    // Caso 2: URL de la nube (ej. "https://.../imagen.jpg")
    if (path.startsWith("http://") || path.startsWith("https://")) {
      final response = await http.get(Uri.parse(path));
      if (response.statusCode == 200) {
        return pw.MemoryImage(response.bodyBytes);
      }
    }

    // Caso 3: Ruta absoluta en sandbox/galería (ej. "/storage/emulated/0/.../foto.jpg")
    final file = File(path);
    if (file.existsSync()) {
      return pw.MemoryImage(file.readAsBytesSync());
    }
  } catch (e) {
    print("Error cargando imagen: $e");
  }
  return null;
}


// Provider para la base de datos
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Provider para el DAO de imágenes
final imageStockmasterDaoProvider = Provider<ImagesStockmasterDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ImagesStockmasterDao(db);
});

// Provider para el Notifier que maneja el estado de imágenes
final imageStockmasterProvider =
NotifierProvider<ImageStockmasterNotifier, List<ImageStockmaster>>(() {
  return ImageStockmasterNotifier();
});
