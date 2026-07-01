import 'package:flutter/material.dart';
import 'package:stockmaster/screens/home_grid_screen.dart';
import 'package:stockmaster/screens/reports_screen.dart';
import 'package:stockmaster/screens/sales_screen.dart';

class RootScreenNew extends StatefulWidget {
  const RootScreenNew({super.key});

  @override
  State<RootScreenNew> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreenNew> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeGridScreen(),   // Pantalla con grilla de 4 imágenes
    const SalesScreen(),      // Pantalla de ventas
    const ReportsScreen(),    // Pantalla de reportes
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRM con Inventario"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
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
          setState(() => _currentIndex = index);
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
