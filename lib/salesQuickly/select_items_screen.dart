import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/products.dart';
import 'package:stockmaster/data/database/local/services.dart';
import '../data/database/local/app_database.dart';
import '/helpers/product_image_helper.dart';

class SelectItemsScreen extends StatefulWidget {
  const SelectItemsScreen({super.key});

  @override
  State<SelectItemsScreen> createState() => _SelectItemsScreenState();
}

class _SelectItemsScreenState extends State<SelectItemsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ProductEntity> _products = [];
  List<ServiceEntity> _services = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    final productDao = Provider.of<ProductDao>(context, listen: false);
    final serviceDao = Provider.of<ServicesDao>(context, listen: false);

    final products = await productDao.getAllProducts();
    final services = await serviceDao.getAllServices();

    setState(() {
      _products = products;
      _services = services;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Ítems'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Productos'),
            Tab(text: 'Servicios'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 🔹 Tab de Productos
          _buildProductList(),
          // 🔹 Tab de Servicios
          _buildServiceList(),
        ],
      ),
    );
  }

  Widget _buildProductList() {
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
            subtitle: Text('Stock: ${p.stock ?? 0} | \$${p.price?.toStringAsFixed(2) ?? '0.00'}'),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                Navigator.pop(context, p); // retorna el producto seleccionado
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceList() {
    if (_services.isEmpty) {
      return const Center(child: Text('No hay servicios disponibles'));
    }

    return ListView.builder(
      itemCount: _services.length,
      itemBuilder: (_, i) {
        final s = _services[i];
        final imageProvider = ProductImageHelper.resolve(s.image);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: imageProvider != null
                ? CircleAvatar(backgroundImage: imageProvider)
                : const CircleAvatar(child: Icon(Icons.design_services)),
            title: Text(s.name ?? 'Sin nombre servicio'),
            subtitle: Text('\$${s.price?.toStringAsFixed(2) ?? '0.00'}'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pop(context, s); // retorna el servicio seleccionado
              },
            ),
          ),
        );
      },
    );
  }
}
