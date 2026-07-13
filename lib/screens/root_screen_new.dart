import 'package:flutter/material.dart';
import 'package:stockmaster/screens/home_grid_screen.dart';
import 'package:stockmaster/screens/reports_screen.dart';
import 'package:stockmaster/screens/sales_screen.dart';

import '../data/database/local/app_database.dart';
import '../data/database/local/product_dao.dart';
import '../data/database/local/inventory_movements_dao.dart';
import '../screens/dashboard/dashboard_inventory_screen.dart'; // 👈 Import del dashboard
import '../data/repositories/sales_repository.dart';

class RootScreenNew extends StatefulWidget {
  const RootScreenNew({super.key});

  @override
  State<RootScreenNew> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreenNew> {
  int _currentIndex = 0;

  late final SalesRepository _salesRepository;
  late final AppDatabase _db;
  late final ProductDao _productDao;
  late final InventoryMovementsDao _inventoryMovementsDao;

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _salesRepository = SalesRepository(_db);
    _productDao = ProductDao(_db);
    _inventoryMovementsDao = InventoryMovementsDao(_db);
  }

  // Pantallas principales (Home, Reportes y DashboardInventarioScreen en IndexedStack)
  late final List<Widget> _screens = [
    const HomeGridScreen(),
    const ReportsScreen(),
    DashboardInventarioScreen(
      productDao: _productDao,
      inventoryMovementsDao: _inventoryMovementsDao,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRM con Inventario"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text("Menú")),
            ListTile(title: Text("Configuración")),
            ListTile(title: Text("Perfil")),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            // 🔹 Navegar con push a SalesScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SalesScreen(),
              ),
            );
          } else {
            // 🔹 Cambiar índice para Home (0) y Reportes/Dashboard (2)
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Ventas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reportes",
          ),
        ],
      ),
    );
  }
}
