import 'package:flutter/material.dart';
import 'package:stockmaster/screens/home_grid_screen.dart';
import 'package:stockmaster/screens/reports_screen.dart';
import 'package:stockmaster/screens/sales_screen.dart';

import '../data/database/local/app_database.dart';
import '../data/repositories/sales_repository.dart';

class RootScreenNew extends StatefulWidget {
  const RootScreenNew({super.key});

  @override
  State<RootScreenNew> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreenNew> {
  int _currentIndex = 0;

  late final SalesRepository _salesRepository;

  @override
  void initState() {
    super.initState();
    final db = AppDatabase();
    _salesRepository = SalesRepository(db);
  }

  // Pantallas principales (solo Home y Reportes se quedan en IndexedStack)
  late final List<Widget> _screens = [
    const HomeGridScreen(),
    const ReportsScreen(),
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
                builder: (_) => SalesScreen(),
              ),
            );
          } else {
            setState(() => _currentIndex = index == 0 ? 0 : 1);
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
