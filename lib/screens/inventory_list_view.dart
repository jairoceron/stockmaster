import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart'; // 🔹 para abrir WhatsApp
import 'package:stockmaster/screens/product_form.dart';
import '../models/user.dart';
import '../providers/inventory_provider.dart';
import '../data/repositories/product_repository.dart';
import '../state/inventory_notifier.dart';
import 'category_filter.dart';
import 'product_search_bar.dart';
import '/services/bar_inventario.dart';
import 'inventory_filter_sheet.dart';
import 'empty_state_widget.dart';
import 'inventory_list_view.dart';
import '../models/product.dart';
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
  bool _modalShown = false; // 🔹 para evitar mostrar el modal varias veces

  @override
  void initState() {
    super.initState();
    _controller = InventoryController(context);

    debugPrint("\n\n  |||||||||||||||||||  products   ${widget.products}  \n\n");
  }

  Future<void> _openWhatsApp() async {
    final phone = "573102952469"; // 🔹 tu número en formato internacional
    final message = Uri.encodeComponent("Hola, quiero enviar mi inventario en Excel para carga automática.");
    final url = Uri.parse("https://wa.me/$phone?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("❌ No se pudo abrir WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryNotifier>();
    final products = widget.products;

    final hasDemoProducts = products.any((p) => p.isdemo == true);

    // 🔹 Mostrar modal si hay más de 20 productos y aún no se mostró
    if (provider.productCount > 2 && !_modalShown) {
      _modalShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: true, // permite cerrar tocando fuera
          builder: (_) => AlertDialog(
            title: Text("inventory.banner.excel".tr()),
            content: Text("inventory.banner.excel_message".tr()),
            actions: [
              TextButton(
                onPressed: _openWhatsApp,
                child: Text("inventory.banner.contact".tr()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("inventory.banner.dismiss".tr()),
              ),
            ],
          ),
        );
      });
    }

    return Stack(
      children: [
        Column(
          children: [
            if (hasDemoProducts) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade200,
                child: Text(
                  "inventory.demo.banner".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                      SnackBar(content: Text("inventory.demo.cleared".tr())),
                    );
                  },
                  child: Text("inventory.demo.clear_button".tr()),
                ),
              ),
            ],
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
                    appBar: AppBar(title: Text("inventory.new_product.title".tr())),
                    body: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ProductForm(),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text("inventory.new_product.button".tr()),
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
