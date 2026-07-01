import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/items.dart';
import 'app_database.dart'; // importa tu AppDatabase

part 'items_dao.g.dart';

@DriftAccessor(tables: [Items])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(AppDatabase db) : super(db);

  // 🔹 Insertar un nuevo Item
  Future<void> insertItem(ItemsEntity item) =>
      into(items).insert(item);

  // 🔹 Obtener todos los Items
  Future<List<ItemsEntity>> getAllItems() =>
      select(items).get();

  // 🔹 Obtener Items por tenantId
  Future<List<ItemsEntity>> getItemsByTenant(String tenantId) {
    return (select(items)..where((tbl) => tbl.tenantId.equals(tenantId))).get();
  }

  // 🔹 Buscar Item por id (UUID)
  Future<ItemsEntity?> getItemById(String id) {
    return (select(items)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // 🔹 Actualizar un Item
  Future<bool> updateItem(ItemsEntity item) =>
      update(items).replace(item);

  // 🔹 Eliminar un Item
  Future<int> deleteItem(String id) {
    return (delete(items)..where((tbl) => tbl.id.equals(id))).go();
  }
}
