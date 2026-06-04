import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/screens/product_form.dart';
import '../models/user.dart';
import '../services/subscription_service.dart';
import '../state/inventory_notifier.dart';
import 'product_search_bar.dart';
import 'inventory_filter_sheet.dart';
import 'empty_state_widget.dart';
import 'inventory_list_view.dart';
import 'package:hugeicons/hugeicons.dart';
import '/utils/decode_token.dart';

class InventoryListScreen extends StatefulWidget {
  final AppUser user;

  const InventoryListScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> {
  late SubscriptionService _subscriptionService;

  @override
  void initState() {
    super.initState();
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const InventoryFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryNotifier>();
    debugPrint("\n\n InventoryListScreen() +++++ EStoy indagando de donde sale el problema ${provider.products} \n\n");

    return Scaffold(
      body: Column(
        children: [
          // Barra de búsqueda
          ProductSearchBar(onSearch: provider.searchProducts),

          // Lista o estado vacío
          Expanded(
            child: provider.products.isEmpty
                ? EmptyStateWidget(onClearFilters: provider.clearFilters)
                : InventoryListView(
              products: provider.products,
              user: widget.user,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "fab_inventory", // 👈 único
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(
                  title: const Text("Nuevo producto"),
                  backgroundColor: const Color(0xFFFFF176), // amarillo pollito
                ),
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ProductForm(), // 👈 ahora no necesita parámetros
                ),
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFFFFF176), // amarillo pollito
        elevation: 6,
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedAddSquare,
          color: Colors.black87,
          size: 36.0,
          strokeWidth: 2.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
