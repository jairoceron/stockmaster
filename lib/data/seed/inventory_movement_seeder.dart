import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/products.dart';
import 'package:stockmaster/data/database/local/inventory_movements.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/inventory_movements_dao.dart';

class InventoryMovementsSeeder {
  final ProductDao productDao;
  final InventoryMovementsDao inventoryMovementsDao;

  InventoryMovementsSeeder(this.productDao, this.inventoryMovementsDao);

  /// Método principal: inserta productos y movimientos si la tabla está vacía
  Future<void> seedInventoryIfEmpty() async {
    // 🔹 Validar si la tabla inventoryMovements está vacía
    final existingMovements = await inventoryMovementsDao.getAllMovements();
    if (existingMovements.isNotEmpty) {
      // Si ya existen movimientos, no hacer nada
      return;
    }

    // Leer archivo JSON desde assets
    final jsonString = await rootBundle.loadString(
        'assets/servicios/movimientoInventario.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Recorrer cada producto con sus movimientos
    for (var item in jsonData) {
      final productData = item['product'] as Map<String, dynamic>;
      final productId = productData['id'] as String;

      // Validar si el producto ya existe
      final existingProduct = await productDao.getProductById(productId);
      if (existingProduct == null) {
        final productEntity = ProductsCompanion(
          id: Value(productId),
          name: Value(productData['name'] as String?),
          stock: Value(productData['stock'] as int?),
          price: Value((productData['precio'] as num?)?.toDouble()),
          image: Value(productData['image'] as String?),
          createdat: Value(DateTime.now()),
          isdemo: const Value(true),
        );
        await productDao.insertProductEntity(productEntity);
      }

      // Extraer movimientos
      final List<dynamic> movementsData = item['inventoryMovements'];

      for (var m in movementsData) {
        final movementId = m['id'] as String;

        // Validar si el movimiento ya existe (aunque la tabla esté vacía, se mantiene la lógica)
        final exists = existingMovements.any((mov) => mov.id == movementId);
        if (exists) continue;

        final movementEntity = InventoryMovementEntity(
          id: movementId,
          productId: m['productId'] as String,
          movementType: m['movementType'] as String,
          quantity: m['quantity'] as int,
          previousStock: m['previousStock'] as int,
          newStock: m['newStock'] as int,
          note: m['note'] as String?,
          timestamp: DateTime.parse(m['timestamp'] as String),
          deviceId: null,
          owner: null,
          syncState: null,
          syncStatus: null,
        );

        await inventoryMovementsDao.insertMovement(movementEntity);
      }
    }
  }
}
