import 'package:drift/drift.dart';
import 'app_database.dart';
import 'sale_items.dart';

part 'sale_items_dao.g.dart';

@DriftAccessor(tables: [SaleItems])
class SaleItemsDao extends DatabaseAccessor<AppDatabase> with _$SaleItemsDaoMixin {
  SaleItemsDao(AppDatabase db) : super(db);

  // ✅ CREATE con Companion
  Future<int> insertSaleItem(SaleItemsCompanion item) => into(saleItems).insert(item);

  // ✅ READ (todos los items)
  Future<List<SaleItemEntity>> getAllSaleItems() => select(saleItems).get();

  // ✅ READ (por id)
  Future<SaleItemEntity?> getSaleItemById(String id) =>
      (select(saleItems)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // ✅ UPDATE con Companion
  Future<bool> updateSaleItem(SaleItemsCompanion item) =>
      update(saleItems).replace(item);

  // ✅ DELETE
  Future<int> deleteSaleItem(String id) =>
      (delete(saleItems)..where((tbl) => tbl.id.equals(id))).go();

  // ✅ Consultas adicionales
  Future<List<SaleItemEntity>> getItemsBySale(String saleId) =>
      (select(saleItems)..where((tbl) => tbl.saleId.equals(saleId))).get();

  Future<List<SaleItemEntity>> getItemsByService(String serviceId) =>
      (select(saleItems)..where((tbl) => tbl.serviceId.equals(serviceId))).get();
}
