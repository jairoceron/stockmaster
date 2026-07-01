import 'dart:io';
import 'package:flutter/material.dart';

/// Clase especializada para resolver el ImageProvider
/// según la fuente de la imagen (URL, assets, filesystem).
class ProductImageHelper {
  /// Retorna el ImageProvider adecuado según el path.
  static ImageProvider? resolve(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      debugPrint('[ProductImageHelper] imagePath vacío o null');
      return null;
    }
    debugPrint('[ProductImageHelper] Resolviendo path: $imagePath');
    // Caso 1: Imagen en la web (URL)
    if (imagePath.startsWith('http')) {
      debugPrint('[ProductImageHelper] Usando NetworkImage');
      return NetworkImage(imagePath);
    }

    // Caso 2: Imagen en assets (bundle de la app)
    if (imagePath.startsWith('assets/')) {
      debugPrint('[ProductImageHelper] Usando AssetImage');
      return AssetImage(imagePath);
    }

    final file = File(imagePath);
    final exists = file.existsSync();
    debugPrint('[ProductImageHelper] File.existsSync($imagePath) = $exists');

    if (exists) {
      debugPrint('[ProductImageHelper] Usando FileImage');
      return FileImage(file);
    }

    debugPrint('[ProductImageHelper] No se encontró el archivo, fallback a null');
    return null;
  }
}
