// product_list_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/products.dart';
import '../../data/database/local/app_database.dart';
import '../../helpers/product_image_helper.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  List<ProductEntity> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final dao = Provider.of<ProductDao>(context, listen: false);
    final products = await dao.getAllProducts();
    setState(() => _products = products);
  }

  @override
  Widget build(BuildContext context) {
    if (_products.isEmpty) {
      return const Center(child: Text('No hay productos disponibles'));
    }

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (_, i) {
        final p = _products[i];
        final imageProvider = ProductImageHelper.resolve(p.image);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: imageProvider != null
                ? CircleAvatar(backgroundImage: imageProvider)
                : const CircleAvatar(child: Icon(Icons.inventory)),
            title: Text(p.name ?? 'Sin nombre'),
            subtitle: Text(
              'Stock: ${p.stock ?? 0} | '
                  'Precio: \$${p.price?.toStringAsFixed(2) ?? '0.00'}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                // Aquí puedes manejar la selección del producto
                // Por ejemplo, retornarlo al flujo de venta rápida
                Navigator.pop(context, p);
              },
            ),
          ),
        );
      },
    );
  }
}
