import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import '../state/inventory_notifier.dart';
import '../screens/product_search_bar.dart';
import '../screens/type_inventory_banner.dart';
import '../services/pdf_catalog_service.dart';


class InventoryAppBar extends StatelessWidget {
  final String title;

  const InventoryAppBar({Key? key, this.title = "Inventario"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryNotifier>();

    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.blue.shade100,
      expandedHeight: 100,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black87),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'catalog') {
              // 👇 Obtén la instancia de AppDatabase desde Provider
              final db = Provider.of<AppDatabase>(context, listen: false);

              // 👇 Crea el servicio con esa instancia
              final pdfService = PdfCatalogService(db);

              // 👇 Llama al método para generar y enviar catálogo
              await pdfService.generateAndSendCatalog(grid: true);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'catalog',
              child: Text('Enviar catálogo'),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ProductSearchBar(onSearch: provider.searchProducts),
              ),
              const SizedBox(width: 8),
              const Expanded(
                flex: 1,
                child: TypeInventoryBanner(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
