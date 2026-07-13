import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/products.dart';
import '../../data/database/local/app_database.dart';
import '../../helpers/product_image_helper.dart';
import '../../providers/sale_state_notifier.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  List<ProductEntity> _products = [];
  final Map<String, ImageProvider?> _imageCache = {};

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final dao = Provider.of<ProductDao>(context, listen: false);
    final products = await dao.getAllProducts();
    setState(() => _products = products);

    // cachear imágenes una sola vez
    for (var p in products) {
      _imageCache[p.id] = ProductImageHelper.resolve(p.image);
    }

    final saleState = Provider.of<SaleStateNotifier>(context, listen: false);
    saleState.registerProducts(products);
  }

  @override
  Widget build(BuildContext context) {
    if (_products.isEmpty) {
      return const Center(child: Text('No hay productos disponibles'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _products.length,
            itemBuilder: (_, i) {
              final p = _products[i];
              final imageProvider = _imageCache[p.id];

              // 🔥 Cada fila observa solo su propia cantidad
              return Selector<SaleStateNotifier, int?>(
                selector: (_, state) => state.selectedProducts[p.id],
                builder: (_, qty, __) {
                  final isSelected = qty != null;
                  final quantity = qty ?? 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      children: [
                        ListTile(
                          leading: imageProvider != null
                              ? CircleAvatar(backgroundImage: imageProvider)
                              : const CircleAvatar(child: Icon(Icons.inventory)),
                          title: Text(p.name ?? 'Sin nombre'),
                          subtitle: Text(
                            'Stock: ${(p.stock ?? 0) - quantity} | '
                                'Precio: \$${p.price?.toStringAsFixed(2) ?? '0.00'}',
                          ),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (val) =>
                                Provider.of<SaleStateNotifier>(context, listen: false)
                                    .toggleProduct(p, val ?? false),
                          ),
                        ),
                        if (isSelected)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Cantidad:",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 120,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline),
                                        onPressed: quantity > 1
                                            ? () => Provider.of<SaleStateNotifier>(
                                            context,
                                            listen: false)
                                            .updateQuantity(p, quantity - 1)
                                            : null,
                                      ),
                                      Text(quantity.toString(),
                                          style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline),
                                        onPressed: () =>
                                            Provider.of<SaleStateNotifier>(context,
                                                listen: false)
                                                .updateQuantity(p, quantity + 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        Consumer<SaleStateNotifier>(
          builder: (_, saleState, __) => Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Total: \$${saleState.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
