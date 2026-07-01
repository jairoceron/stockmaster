import 'package:drift/drift.dart';
import 'services.dart';
import 'package:stockmaster/data/database/local/app_database.dart';

part 'services_dao.g.dart';

@DriftAccessor(tables: [Services])
class ServicesDao extends DatabaseAccessor<AppDatabase> with _$ServicesDaoMixin {
  ServicesDao(AppDatabase db) : super(db);

  // ✅ CREATE
  Future<int> insertService(ServiceEntity service) =>
      into(services).insert(service);

  // ✅ READ (todos los servicios)
  Future<List<ServiceEntity>> getAllServices() =>
      select(services).get();

  // ✅ READ (por id)
  Future<ServiceEntity?> getServiceById(String id) =>
      (select(services)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // ✅ UPDATE (entidad completa)
  Future<bool> updateService(ServiceEntity service) =>
      update(services).replace(service);

  // ✅ DELETE
  Future<int> deleteService(String id) =>
      (delete(services)..where((tbl) => tbl.id.equals(id))).go();

  // ✅ UPDATE SOLO IMAGEN
  Future<int> updateServiceImage(String id, String newPath) {
    return (update(services)..where((tbl) => tbl.id.equals(id)))
        .write(ServicesCompanion(
      image: Value(newPath),
      createdAt: Value(DateTime.now()), // opcional: refrescar fecha
    ));
  }
}
