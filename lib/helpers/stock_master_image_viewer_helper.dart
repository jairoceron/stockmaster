import 'package:flutter/material.dart';
import 'package:stockmaster/helpers/product_image_helper.dart';


import 'package:flutter/material.dart';
import 'package:stockmaster/helpers/product_image_helper.dart';

/// Helper especializado para mostrar imágenes con zoom y fallback.
class StockMasterImageViewerHelper {
  /// Construye el widget de imagen con zoom y fallback.
  static Widget buildImage({
    required BuildContext context,
    required String? imagePath,
    required bool loading,
    required VoidCallback onTap,
  }) {
    final resolvedImage = ProductImageHelper.resolve(imagePath);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 🔹 Mantener altura fija para evitar errores de layout
        height: 120,
        width: 120, // agregado para dar restricciones claras
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : (imagePath == null || imagePath.isEmpty || resolvedImage == null)
            ? const Icon(Icons.inventory_2_outlined, size: 40)
            : ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1.0,
            maxScale: 4.0,
            child: Image(
              image: resolvedImage,
              // 🔹 Ajustar tamaño para respetar restricciones
              height: 120,
              width: 120,
              fit: BoxFit.cover, // cambio de contain → cover para miniaturas
            ),
          ),
        ),
      ),
    );
  }
}
