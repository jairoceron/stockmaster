import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/product.dart';

/// Vista de lista de productos arrastrables con selección de foto
class ProductListView extends StatefulWidget {
  final List<Product> products;

  const ProductListView({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ImagePicker _picker = ImagePicker();

  /// Método para seleccionar foto desde cámara o galería
  Future<void> _seleccionarFoto(Product p) async {
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

      if (opcion == null) return;

      final foto = await _picker.pickImage(source: opcion, imageQuality: 80);

      if (foto != null) {
        final dir = await getApplicationDocumentsDirectory();
        final path = '${dir.path}/${p.id}_image.jpg';
        await foto.saveTo(path);

        setState(() {
          p.image = path;
        });
      }
    } catch (e) {
      debugPrint('Error al seleccionar foto: $e');
    }
  }

  /// Método para resolver la imagen según el campo p.image
  ImageProvider? _resolverImagen(Product p) {
    if (p.image == null || p.image!.isEmpty) {
      return null;
    } else if (p.image!.startsWith('assets/')) {
      return AssetImage(p.image!);
    } else {
      return FileImage(File(p.image!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: widget.products.length,
      itemBuilder: (ctx, i) {
        final p = widget.products[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Draggable<Product>(
            data: p,
            feedback: Material(
              elevation: 6,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Card(
                  child: ListTile(
                    title: Text(p.name ?? 'Sin nombre'),
                    subtitle: Text(
                      'Stock: ${p.stock ?? 0} | Price: ${p.price?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      backgroundImage: _resolverImagen(p),
                      child: (p.image == null || p.image!.isEmpty)
                          ? const Icon(Icons.inventory)
                          : null,
                    ),
                  ),
                ),
              ),
            ),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: ListTile(
                title: Text(p.name ?? 'Sin nombre'),
                subtitle: Text(
                  'Stock: ${p.stock ?? 0} | Price: ${p.price?.toStringAsFixed(2) ?? '0.00'}',
                ),
                leading: GestureDetector(
                  onTap: () => _seleccionarFoto(p),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    backgroundImage: _resolverImagen(p),
                    child: (p.image == null || p.image!.isEmpty)
                        ? const Icon(Icons.inventory)
                        : null,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
