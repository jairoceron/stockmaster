import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/third_parts.dart';
import '/helpers/uuid_helper.dart';
import 'app_database.dart'; // Ajusta la ruta según tu proyecto

part 'third_parts_dao.g.dart';

@DriftAccessor(tables: [ThirdParts])
class ThirdPartsDao extends DatabaseAccessor<AppDatabase>
    with _$ThirdPartsDaoMixin {
  final AppDatabase db;

  ThirdPartsDao(this.db) : super(db);

  // 🔹 Insertar un nuevo tercero
  Future<void> insertThirdPart(ThirdPartEntity entity) =>
      into(thirdParts).insert(entity);

  // 🔹 Insertar o actualizar (upsert)
  Future<void> upsertThirdPart(ThirdPartEntity entity) =>
      into(thirdParts).insertOnConflictUpdate(entity);

  // 🔹 Obtener todos los terceros
  Future<List<ThirdPartEntity>> getAllThirdParts() =>
      select(thirdParts).get();

  // 🔹 Buscar tercero por ID
  Future<ThirdPartEntity?> getThirdPartById(String id) =>
      (select(thirdParts)..where((t) => t.id.equals(id))).getSingleOrNull();



  // 🔹 Buscar por nombre (LIKE)
  Future<List<ThirdPartEntity>> searchByName(String query) =>
      (select(thirdParts)..where((t) => t.name.like('%$query%'))).get();

  // 🔹 Filtrar por tipo de tercero (cliente, proveedor, etc.)
  Future<List<ThirdPartEntity>> getByType(String type) =>
      (select(thirdParts)..where((t) => t.thirdPartType.equals(type))).get();

  // 🔹 Actualizar tercero
  //Future<bool> updateThirdPart(ThirdPartEntity entity) =>
  //    update(thirdParts).replace(entity);

  // 🔹 Eliminar tercero por ID
  Future<int> deleteThirdPart(String id) =>
      (delete(thirdParts)..where((t) => t.id.equals(id))).go();

  Future<int> updateThirdPart(ThirdPartEntity entity) {
    return (update(thirdParts)..where((tbl) => tbl.id.equals(entity.id)))
        .write(ThirdPartsCompanion(
      name: Value(entity.name),
      phone: Value(entity.phone),
      email: Value(entity.email),
      notes: Value(entity.notes),
      imageUrl: Value(entity.imageUrl), // aquí se guarda la ruta real
      updatedAt: Value(DateTime.now()),
    ));
  }


}
