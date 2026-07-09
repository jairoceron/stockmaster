import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/models/image_stockmaster.dart';

class ProductPhotoHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Selecciona una foto desde cámara o galería y devuelve la ruta del archivo.
  static Future<String?> seleccionarFoto(
      BuildContext context,
      ImageStockmaster imageStockMaster,
      Function(bool) setLoading,
      ) async {
    try {
      final opcion = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (ctx) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar foto'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Cargar desde galería'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      );

      if (opcion == null) return null;

      setLoading(true);

      final XFile? xfile = await _picker.pickImage(
        source: opcion,
        imageQuality: 90,
      );

      if (xfile == null) {
        setLoading(false);
        return null;
      }

      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          '${imageStockMaster.ownerId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newPath = '${appDir.path}/$fileName';
      await File(xfile.path).copy(newPath);

      // 🔹 Crear miniatura optimizada
      final thumbPath = '${appDir.path}/${imageStockMaster.ownerId}_thumb.jpg';
      await File(xfile.path).copy(thumbPath);

      setLoading(false);

      return newPath; // devolvemos la ruta real de la imagen
    } on PlatformException {
      setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo acceder a la cámara/galería")),
      );
      return null;
    } on FileSystemException {
      setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al guardar la foto")),
      );
      return null;
    }
  }
}
