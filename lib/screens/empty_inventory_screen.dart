import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/type_inventories_dao.dart';
import 'package:stockmaster/helpers/inventory_selection_helper.dart';
import 'package:stockmaster/providers/inventory_type_provider.dart';

import '../data/database/local/app_database.dart';

class EmptyInventoryScreen extends StatelessWidget {
  const EmptyInventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ AppBar con botón de retroceso
      appBar: AppBar(
        title: const Text("Inventario vacío"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Bienvenido a StockMaster",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Selecciona el tipo de negocio para comenzar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),

              // Grid de categorías con imágenes desde BD
              Expanded(
                child: Consumer<TypeInventoriesDao>(
                  builder: (context, dao, _) {
                    return FutureBuilder<List<TypeInventoryEntity>>(
                      future: dao.getActiveTypes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          debugPrint("❌ Error en getActiveTypes: ${snapshot.error}");
                          debugPrint("StackTrace: ${snapshot.stackTrace}");
                          return Center(child: Text("Error: ${snapshot.error}"));
                        }
                        final categories = snapshot.data ?? [];

                        if (categories.isEmpty) {
                          return const Center(child: Text("No hay categorías disponibles"));
                        }

                        return GridView.builder(
                          itemCount: categories.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () {
                                final selectedType = category.nombrees;

                                context.read<InventoryTypeProvider>().setInventoryType(selectedType);
                                InventorySelectionHelper.updateInventoryType(context, selectedType);

                                Navigator.pushNamed(context, '/mainProduct');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    category.pathimage,
                                    width: 160,
                                    height: 160,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    category.nombrees,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/mainProduct'),
                icon: const Icon(Icons.add_box_rounded),
                label: const Text("Comenzar mi inventario"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
