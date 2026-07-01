import 'package:flutter/material.dart';

import 'package:stockmaster/helpers/stock_master_image_viewer_helper.dart';
import 'package:stockmaster/helpers/product_photo_helper.dart';
import 'package:stockmaster/models/image_stockmaster.dart';
import 'package:stockmaster/models/third_part.dart';

class ClientListItem extends StatelessWidget {
  final ThirdPart client;
  final bool loadingImage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTapDetail;
  final Future<void> Function(String newPath) onImageSelected;
  final void Function(bool) onLoadingChanged;

  const ClientListItem({
    super.key,
    required this.client,
    required this.loadingImage,
    required this.onEdit,
    required this.onDelete,
    required this.onTapDetail,
    required this.onImageSelected,
    required this.onLoadingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final imageStockmaster = ImageStockmaster(
      id: client.id,
      path: client.imageUrl ?? '',
      ownerType: 'client',
      ownerId: client.id,
      thumbnailPath: null,
      createdAt: DateTime.now(),
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: SizedBox(
          width: 48,
          height: 48,
          child: StockMasterImageViewerHelper.buildImage(
            context: context,
            imagePath: imageStockmaster.path,
            loading: loadingImage,
            onTap: () async {
              final path = await ProductPhotoHelper.seleccionarFoto(
                context,
                imageStockmaster,
                    (loading) => onLoadingChanged(loading),
              );

              if (path != null) {
                await onImageSelected(path);
              }
            },
          ),
        ),
        title: Text(client.name),
        subtitle: Text(client.email ?? ''),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              onEdit();
            } else if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Editar')),
            PopupMenuItem(value: 'delete', child: Text('Eliminar')),
          ],
        ),
        onTap: onTapDetail,
      ),
    );
  }
}
