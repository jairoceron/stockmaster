import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/screens/product_form.dart';
import '../models/user.dart';
import '../providers/inventory_provider.dart';
import '../data/repositories/product_repository.dart';
import '../state/inventory_notifier.dart';
import 'category_filter.dart';
import 'product_search_bar.dart';
import '/services/bar_inventario.dart'; // ✅ AppBar personalizado
import 'inventory_filter_sheet.dart';
import 'empty_state_widget.dart';
import 'inventory_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../providers/inventory_provider.dart';
import '../controllers/inventory_controller.dart';
import 'product_list_item.dart';

class InventoryListView extends StatefulWidget {
  final List<Product> products;
  final AppUser user;

  const InventoryListView({
    Key? key,
    required this.products,
    required this.user,
  }) : super(key: key);

  @override
  State<InventoryListView> createState() => _InventoryListViewState();
}

class _InventoryListViewState extends State<InventoryListView> {



  final ScrollController _scrollController = ScrollController();
  late InventoryController _controller;
  bool _hasRequestedNextPage = false;

  @override
  void initState() {
    super.initState();
    _controller = InventoryController(context);


    debugPrint("\n\n  |||||||||||||||||||  products   ${widget.products}  \n\n");

    _scrollController.addListener(() {
      /*
      final provider = context.read<ProductRepository>();
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100 &&
          !provider.isLoading &&
          provider.hasMore &&
          !_hasRequestedNextPage) {
        _hasRequestedNextPage = true;
        provider.loadProductsForUser(widget.user , context).then((_) {
          _hasRequestedNextPage = false;
        });
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryNotifier>();
    final products = widget.products;

    // 🔹 Verificar si hay productos demo
    final hasDemoProducts = products.any((p) => p.isdemo == true);

    return Stack(
      children: [
        Column(
          children: [
            // 🔹 Banner y botón solo si hay productos demo
            if (hasDemoProducts) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade200,
                child: const Text(
                  "Estos son productos de ejemplo. Puedes borrarlos y añadir tus propios productos",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await provider.borrarRegistrosDeDemo();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Inventario demo vaciado")),
                    );
                  },
                  child: const Text("Vaciar Inventario Demo"),
                ),
              ),
            ],

            // 🔹 Lista de productos
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: products.length + (provider.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < products.length) {
                    final product = products[index];
                    return ProductListItem(
                      product: product,
                      controller: _controller,
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),

        // 🔹 Botón fijo inferior
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text("Nuevo producto")),
                    body: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ProductForm(), // 👈 tu formulario
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Añadir Nuevo Producto"),
          ),
        ),
      ],
    );
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
