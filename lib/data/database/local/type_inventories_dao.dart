import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/type_inventories.dart';
import 'app_database.dart'; // tu clase principal de base de datos

part 'type_inventories_dao.g.dart';

@DriftAccessor(tables: [TypeInventories])
class TypeInventoriesDao extends DatabaseAccessor<AppDatabase>
    with _$TypeInventoriesDaoMixin {
  TypeInventoriesDao(AppDatabase db) : super(db);

  // 🔎 Obtener todos los tipos de inventario
  Future<List<TypeInventoryEntity>> getAllTypes() =>
      select(typeInventories).get();

  // 🔎 Obtener un tipo de inventario por ID
  Future<TypeInventoryEntity?> getTypeById(int id) {
    return (select(typeInventories)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  // ➕ Insertar un nuevo tipo de inventario
  Future<int> insertType(TypeInventoriesCompanion entry) =>
      into(typeInventories).insert(entry);

  // ✏️ Actualizar un tipo de inventario existente
  Future<bool> updateType(TypeInventoryEntity entity) =>
      update(typeInventories).replace(entity);

  // 🗑️ Eliminar un tipo de inventario por ID
  Future<int> deleteType(int id) =>
      (delete(typeInventories)..where((tbl) => tbl.id.equals(id))).go();

  // 🔎 Obtener solo los activos
  Future<List<TypeInventoryEntity>> getActiveTypes() {
    return (select(typeInventories)..where((tbl) => tbl.activo.equals(true)))
        .get();
  }
}
