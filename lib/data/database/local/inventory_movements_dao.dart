import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/products.dart';
import 'package:stockmaster/data/database/local/inventory_movements.dart';

part 'inventory_movements_dao.g.dart';

@DriftAccessor(tables: [InventoryMovements, Products])
class InventoryMovementsDao extends DatabaseAccessor<AppDatabase>
    with _$InventoryMovementsDaoMixin {
  InventoryMovementsDao(AppDatabase db) : super(db);

  // 🔹 Insertar un movimiento
  Future<void> insertMovement(InventoryMovementEntity movement) async {
    await into(inventoryMovements).insert(movement);
  }

  // 🔹 Actualizar un movimiento
  Future<bool> updateMovement(InventoryMovementEntity movement) async {
    return update(inventoryMovements).replace(movement);
  }

  // 🔹 Eliminar un movimiento
  Future<int> deleteMovement(String id) async {
    return (delete(inventoryMovements)..where((tbl) => tbl.id.equals(id))).go();
  }

  // 🔹 Obtener todos los movimientos
  Future<List<InventoryMovementEntity>> getAllMovements() async {
    return select(inventoryMovements).get();
  }

  // 🔹 Obtener movimientos por producto
  Future<List<InventoryMovementEntity>> getMovementsByProduct(String productId) async {
    return (select(inventoryMovements)
      ..where((tbl) => tbl.productId.equals(productId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)]))
        .get();
  }

  // 🔹 Reporte: stock actual de un producto
  Future<int?> getCurrentStock(String productId) async {
    final query = (select(inventoryMovements)
      ..where((tbl) => tbl.productId.equals(productId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)])
      ..limit(1))
        .getSingleOrNull();

    final lastMovement = await query;
    return lastMovement?.newStock;
  }

  // 🔹 Reporte: totales de entradas y salidas
  Future<Map<String, int>> getTotals(String productId) async {
    final entradas = await (select(inventoryMovements)
      ..where((tbl) =>
      tbl.productId.equals(productId) &
      tbl.movementType.equals('entrada')))
        .get();

    final salidas = await (select(inventoryMovements)
      ..where((tbl) =>
      tbl.productId.equals(productId) &
      tbl.movementType.equals('salida')))
        .get();

    final totalEntradas =
    entradas.fold<int>(0, (sum, e) => sum + e.quantity);
    final totalSalidas =
    salidas.fold<int>(0, (sum, e) => sum + e.quantity);

    return {
      'entradas': totalEntradas,
      'salidas': totalSalidas,
    };
  }

  // 🔹 Reporte: datos para gráficas (stock vs tiempo)
  Future<List<Map<String, dynamic>>> getStockTimeline(String productId) async {
    final rows = await (select(inventoryMovements)
      ..where((tbl) => tbl.productId.equals(productId))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.timestamp)]))
        .get();

    return rows
        .map((e) => {
      'timestamp': e.timestamp,
      'stock': e.newStock,
      'type': e.movementType,
      'quantity': e.quantity,
    })
        .toList();
  }
}
