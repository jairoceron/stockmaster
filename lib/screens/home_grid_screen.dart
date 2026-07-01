import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:stockmaster/screens/bottom_navigation_bar.dart';
import 'package:stockmaster/screens/services/services_list_screen.dart';
import 'package:stockmaster/screens/thirdParts/clients_list_screen.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';

class HomeGridScreen extends StatelessWidget {
  const HomeGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Clientes", "icon": Icons.people},
      {"title": "Inventario", "icon": Icons.inventory},
      {"title": "Ventas", "icon": Icons.shopping_cart},
      {"title": "Reportes", "icon": Icons.bar_chart},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];

        // Caso especial: dividir Inventario en Inventario + Servicios
        if (item["title"] == "Inventario") {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const BottomNavBar()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.inventory, size: 40),
                        SizedBox(height: 4),
                        Text("Inventario", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, thickness: 1),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // 👇 Aquí obtenemos el ServicesDao del Provider
                      final servicesDao = provider.Provider.of<ServicesDao>(
                        context,
                        listen: false,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServicesListScreen(
                            servicesDao: servicesDao,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.design_services, size: 40),
                        SizedBox(height: 4),
                        Text("Servicios", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Caso normal para otros ítems
        return GestureDetector(
          onTap: () {
            if (item["title"] == "Clientes") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClientsListScreen()),
              );
            }
            if (item["title"] == "Ventas") {
              // Aquí puedes añadir navegación para Ventas
            }
            if (item["title"] == "Reportes") {
              // Aquí puedes añadir navegación para Reportes
            }
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item["icon"] as IconData, size: 48),
                const SizedBox(height: 8),
                Text(
                  item["title"] as String,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
