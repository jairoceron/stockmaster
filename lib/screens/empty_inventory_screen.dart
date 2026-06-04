import 'package:flutter/material.dart';

class EmptyInventoryScreen extends StatelessWidget {
  const EmptyInventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono cálido y amigable
            Icon(Icons.inventory_rounded, size: 120, color: Colors.orange),

            const SizedBox(height: 24),

            // Título motivador
            const Text(
              "Tu inventario está listo para crecer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            // Mensaje secundario breve y claro
            const Text(
              "Agrega tu primer producto y empieza a organizar tu negocio de forma sencilla.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 32),

            // Botón principal motivador
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/mainProduct'),
              icon: const Icon(Icons.add_box_rounded),
              label: const Text("Agregar mi primer producto"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
