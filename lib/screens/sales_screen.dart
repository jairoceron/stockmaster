import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El AppBar y BottomNavigationBar ya vienen del RootScreen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado interno
            const Text(
              "Gestión de Ventas",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Tarjeta resumen de ventas
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.attach_money, size: 40, color: Colors.green),
                title: const Text("Ventas del día"),
                subtitle: const Text("Total: \$1,250.00"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navegar a detalle de ventas
                },
              ),
            ),
            const SizedBox(height: 16),

            // Lista de ventas recientes
            Expanded(
              child: ListView.builder(
                itemCount: 5, // ejemplo
                itemBuilder: (_, i) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.receipt_long, color: Colors.blue),
                      title: Text("Venta #${i + 1}"),
                      subtitle: const Text("Cliente: Juan Pérez\nTotal: \$250.00"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Abrir detalle de la venta
                      },
                    ),
                  );
                },
              ),
            ),

            // Botón principal para nueva venta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text("Registrar nueva venta"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Acción para crear nueva venta
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
