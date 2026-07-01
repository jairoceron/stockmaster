import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/helpers/product_image_helper.dart';
import 'package:stockmaster/helpers/product_photo_helper.dart';
import 'package:stockmaster/models/image_stockmaster.dart';
import 'package:stockmaster/screens/services/service_form_screen.dart';
import 'package:stockmaster/helpers/uuid_helper.dart';

class ServiceCard extends StatefulWidget {
  final ServiceEntity service;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function(ServiceEntity updatedService) onUpdateImage;

  const ServiceCard({
    Key? key,
    required this.service,
    required this.onDelete,
    required this.onUpdateImage,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _loadingImage = false;
  late String? _currentImagePath;

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.service.image;
  }

  Future<void> _handleImageTap(BuildContext context) async {
    final newPath = await ProductPhotoHelper.seleccionarFoto(
      context,
      ImageStockmaster(
        id: generateUuid(),
        path: _currentImagePath ?? '',
        ownerType: 'service',
        ownerId: widget.service.id,
      ),
          (loading) {
        setState(() {
          _loadingImage = loading;
        });
      },
    );

    if (newPath != null) {
      // Crear entidad de imagen para registrar en tabla images_stockmaster
      final imageEntity = ImageStockmaster(
        id: generateUuid(),
        path: newPath,
        ownerType: 'service',
        ownerId: widget.service.id,
        thumbnailPath: null,
      );

      // Actualizar el servicio con la nueva ruta de imagen usando Value()
      final updatedService = widget.service.copyWith(image: Value(newPath));
      await widget.onUpdateImage(updatedService);

      setState(() {
        _currentImagePath = newPath;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Imagen actualizada correctamente")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolvedImage = ProductImageHelper.resolve(_currentImagePath);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        leading: GestureDetector(
          onTap: () => _handleImageTap(context),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.withOpacity(0.1),
            ),
            child: _loadingImage
                ? const Center(child: CircularProgressIndicator())
                : (resolvedImage == null)
                ? const Icon(Icons.design_services, size: 40)
                : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: resolvedImage,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              ),
            ),
          ),
        ),
        title: Text(widget.service.name ?? "Servicio sin nombre"),
        subtitle: Text(
          "Precio: \$${widget.service.price?.toStringAsFixed(2) ?? '--'}\nDuración: ${widget.service.durationMinutes ?? '--'} min",
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ServiceFormScreen(),
                ),
              );
            } else if (value == 'delete') {
              widget.onDelete(widget.service.id);
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'edit',
              child: Text("Modificar"),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text("Eliminar"),
            ),
          ],
        ),
      ),
    );
  }
}
