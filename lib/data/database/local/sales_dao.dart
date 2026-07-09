import 'package:drift/drift.dart';
import 'app_database.dart';
import 'sales.dart';
import 'third_parts.dart';

part 'sales_dao.g.dart';

@DriftAccessor(tables: [Sales, ThirdParts])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  SalesDao(AppDatabase db) : super(db);

  // ✅ CREATE con Companion
  Future<int> insertSale(SalesCompanion sale) => into(sales).insert(sale);

  // ✅ READ (todas las ventas sin orden específico)
  Future<List<SaleEntity>> getAllSalesRaw() => select(sales).get();

  // ✅ READ (todas las ventas ordenadas por fecha descendente)
  Future<List<SaleEntity>> getAllSales() {
    return (select(sales)
      ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.date),
      ]))
        .get();
  }

  // ✅ READ (por id)
  Future<SaleEntity?> getSaleById(String id) =>
      (select(sales)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // ✅ UPDATE con Companion
  Future<bool> updateSale(SalesCompanion sale) => update(sales).replace(sale);

  // ✅ DELETE
  Future<int> deleteSale(String id) =>
      (delete(sales)..where((tbl) => tbl.id.equals(id))).go();

  // ✅ Consultas adicionales
  Future<List<SaleEntity>> getSalesByClient(String clientId) =>
      (select(sales)..where((tbl) => tbl.clientId.equals(clientId))).get();

  Future<List<SaleEntity>> getSalesByDate(DateTime date) =>
      (select(sales)..where((tbl) => tbl.date.equals(date))).get();

  /// 🔹 Nuevo método: join con ThirdParts para obtener nombre e imagen del cliente
  Future<List<Map<String, dynamic>>> getSalesWithClients() async {
    final query = (select(sales)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .join([
      leftOuterJoin(thirdParts, thirdParts.id.equalsExp(sales.clientId)),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final sale = row.readTable(sales);
      final client = row.readTableOrNull(thirdParts);

      return {
        'saleId': sale.id,
        'date': sale.date,
        'price': sale.totalAmount,
        'paymentMethod': sale.paymentMethod,
        'clientId': sale.clientId,
        'clientName': client?.name ?? 'Venta rápida',
        'imageUrl': client?.imageUrl, // ✅ ruta de la imagen del cliente
      };
    }).toList();
  }
}
