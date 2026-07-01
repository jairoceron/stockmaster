import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/repositories/product_image_repository.dart';
import '../helpers/product_photo_helper.dart';
import '../helpers/stock_master_image_viewer_helper.dart';
import '../models/product.dart';
import '../models/image_stockmaster.dart'; // 🔹 Import del modelo
import '../controllers/inventory_controller.dart';
import '../state/inventory_notifier.dart';
import '../providers/inventory_type_provider.dart';
import '../domain/strategies/menu_strategy_factory.dart';
import '../screens/lots/product_lot_form_screen.dart';
import '../data/database/local/product_dao.dart';


class ProductCardItem extends StatefulWidget {
  final Product product;
  final InventoryController controller;

  const ProductCardItem({
    Key? key,
    required this.product,
    required this.controller,
  }) : super(key: key);

  @override
  State<ProductCardItem> createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  bool _loadingImage = false;

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

    final inventoryType = context.watch<InventoryTypeProvider>().inventoryType;
    final strategy = MenuStrategyFactory.getStrategy(inventoryType);

    final imageStockmaster = ImageStockmaster(
      id: p.id,
      path: p.image ?? '',
      ownerType: 'product',
      ownerId: p.id ?? '',
      thumbnailPath: null,
      createdAt: DateTime.now(),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Columna 1: Imagen
            Expanded(
              flex: 2,
              child: StockMasterImageViewerHelper.buildImage(
                context: context,
                imagePath: imageStockmaster.path,
                loading: _loadingImage,
                onTap: () async {
                  final path = await ProductPhotoHelper.seleccionarFoto(
                    context,
                    imageStockmaster,
                        (loading) => setState(() => _loadingImage = loading),
                  );

                  if (path != null) {
                    setState(() {
                      p.image = path;
                    });

                    // 🔹 Actualizar en BD usando el repositorio
                    final dao = context.read<ProductDao>();
                    final repo = ProductImageRepository(dao);
                    await repo.updateProductImage(p.id!, path);
                  }
                },
              ),
            ),

            const SizedBox(width: 8),

            // Columna 2: Info del producto
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre + DEMO
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

                  // Precio + botones
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
                          } else if (value == 'lot') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProductLotFormScreen(
                                  productLot: null,
                                ),
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) =>
                            strategy.buildMenu(p, widget.controller, context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 0.5),

                  Container(
                    height: 1,
                    color: Colors.black26,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),

                  // Stock + botón disminuir
                  Row(
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
