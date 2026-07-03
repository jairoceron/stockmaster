import 'package:drift/drift.dart';
import 'app_database.dart';
import 'sales.dart';

part 'sales_dao.g.dart';

@DriftAccessor(tables: [Sales])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  SalesDao(AppDatabase db) : super(db);

  // ✅ CREATE con Companion
  Future<int> insertSale(SalesCompanion sale) => into(sales).insert(sale);

  // ✅ READ (todas las ventas)
  Future<List<SaleEntity>> getAllSales() => select(sales).get();

  // ✅ READ (por id)
  Future<SaleEntity?> getSaleById(String id) =>
      (select(sales)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // ✅ UPDATE con Companion
  Future<bool> updateSale(SalesCompanion sale) =>
      update(sales).replace(sale);

  // ✅ DELETE
  Future<int> deleteSale(String id) =>
      (delete(sales)..where((tbl) => tbl.id.equals(id))).go();

  // ✅ Consultas adicionales
  Future<List<SaleEntity>> getSalesByClient(String clientId) =>
      (select(sales)..where((tbl) => tbl.clientId.equals(clientId))).get();

  Future<List<SaleEntity>> getSalesByDate(DateTime date) =>
      (select(sales)..where((tbl) => tbl.date.equals(date))).get();
}
