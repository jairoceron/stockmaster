import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../data/database/local/product_dao.dart';
import '../models/product.dart';
import '../controllers/inventory_controller.dart';
import '../state/inventory_notifier.dart';

class ProductListItem extends StatefulWidget {
  final Product product;
  final InventoryController controller;

  const ProductListItem({
    Key? key,
    required this.product,
    required this.controller,
  }) : super(key: key);

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  final ImagePicker _picker = ImagePicker();
  bool _loadingImage = false;

  Future<void> _seleccionarFoto(Product product) async {
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

      setState(() => _loadingImage = true);

      final XFile? xfile = await ImagePicker().pickImage(
        source: opcion,
        imageQuality: 90,
      );

      if (xfile == null) {
        setState(() => _loadingImage = false);
        return;
      }

      final appDir = await getApplicationDocumentsDirectory();
      final newPath = '${appDir.path}/${product.id}_image.jpg';
      final savedFile = await File(xfile.path).copy(newPath);

      setState(() {
        product.image = savedFile.path;
        _loadingImage = false;
      });

      final dao = context.read<ProductDao>();
      await dao.updateProductImage(product.id!, savedFile.path);

    } on PlatformException {
      setState(() => _loadingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo acceder a la cámara/galería")),
      );
    } on FileSystemException {
      setState(() => _loadingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al guardar la foto")),
      );
    }
  }

  ImageProvider? _resolverImagen(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;
    final file = File(imagePath);
    return file.existsSync() ? FileImage(file) : null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryNotifier>();
    final theme = Theme.of(context);
    final p = widget.product;

    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Columna 1: Imagen (20%)
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => _seleccionarFoto(p),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    image: _resolverImagen(p.image) != null
                        ? DecorationImage(
                      image: _resolverImagen(p.image)!,
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: _loadingImage
                      ? const Center(child: CircularProgressIndicator())
                      : (p.image == null || p.image!.isEmpty)
                      ? const Icon(Icons.inventory_2_outlined, size: 40)
                      : null,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Columna 2: Grilla con 4 filas (80%)
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fila 1: Nombre + DEMO (si aplica)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.name ?? 'Sin nombre',
                          style: theme.textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (p.isdemo == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'DEMO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 0.5),

                  // Fila 2: Precio + botón aumentar + menú contextual
                  Row(
                    children: [
                      IconButton(
                        iconSize: 32,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () {
                          widget.controller.updateStock(p, 1);
                          provider.updateStock(p, 1);
                        },
                      ),
                      Text('Precio: ', style: theme.textTheme.bodyMedium),
                      Text(
                        formatter.format(p.price),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton<String>(
                        iconSize: 32,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onSelected: (value) {
                          if (value == 'edit') {
                            widget.controller.showEditBottomSheet(context, p);
                          } else if (value == 'delete') {
                            widget.controller.confirmDelete(context, p);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${p.name} eliminado')),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: ListTile(
                              leading: Icon(Icons.edit, color: Colors.blue),
                              title: Text('Editar'),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: ListTile(
                              leading: Icon(Icons.delete, color: Colors.red),
                              title: Text('Eliminar'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 0.5),

                  // Raya divisoria
                  Container(
                    height: 1,
                    color: Colors.black26,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),

                  // Fila 3: Stock + botón disminuir
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        iconSize: 32,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          widget.controller.updateStock(p, -1);
                          provider.updateStock(p, -1);
                        },
                      ),
                      const SizedBox(width: 4),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          'Stock: ${p.stock ?? 0} Unidades',
                          key: ValueKey(p.stock),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


  }
}
