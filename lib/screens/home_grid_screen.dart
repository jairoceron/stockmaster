import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:stockmaster/screens/bottom_navigation_bar.dart';
import 'package:stockmaster/screens/sale/quick_sale_form_screen.dart';
import 'package:stockmaster/screens/services/services_list_screen.dart';
import 'package:stockmaster/screens/thirdParts/clients_list_screen.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';

class HomeGridScreen extends StatelessWidget {
  const HomeGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Clientes", "asset": "assets/menu/clientes.png"},
      {"title": "Inventario", "asset": "assets/menu/inventario.png"},
      {"title": "Ventas", "asset": "assets/menu/carrito.png"},
      {"title": "Reportes", "asset": "assets/menu/reporte.png"},
      {"title": "Servicios", "asset": "assets/menu/servicios.png"},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 👈 Dos elementos por fila
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];

        return GestureDetector(
          onTap: () {
            if (item["title"] == "Clientes") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClientsListScreen()),
              );
            }
            if (item["title"] == "Inventario") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BottomNavBar()),
              );
            }
            if (item["title"] == "Ventas") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuickSaleFormScreen()),
              );
            }
            if (item["title"] == "Servicios") {
              final servicesDao = provider.Provider.of<ServicesDao>(
                context,
                listen: false,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServicesListScreen(servicesDao: servicesDao),
                ),
              );
            }
            if (item["title"] == "Reportes") {
              // Aquí puedes añadir navegación para Reportes
            }
          },
          child: Card(
            elevation: 6,
            color: Colors.white,
            shadowColor: Colors.grey.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      item["asset"] as String,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item["title"] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
