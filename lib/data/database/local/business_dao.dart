import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/businesss.dart';
import 'app_database.dart';
// asegúrate que este archivo define la tabla Business con idbusiness TEXT

part 'business_dao.g.dart';

@DriftAccessor(tables: [Businesss])
class BusinessDao extends DatabaseAccessor<AppDatabase>
    with _$BusinessDaoMixin {
  BusinessDao(AppDatabase db) : super(db);

  // 🔹 Obtener el primer registro
  Future<BusinessEntity?> getFirstBusiness() async {
    return (select(businesss)..limit(1)).getSingleOrNull();
  }

  // 🔹 Obtener solo el idbusiness del primer registro
  Future<String?> getFirstBusinessId() async {
    final business = await getFirstBusiness();
    return business?.idbusiness;
  }

  // 🔹 Obtener todos los registros
  Future<List<BusinessEntity>> getAllBusiness() =>
      select(businesss).get();

  // 🔹 Obtener un registro por idbusiness (String)
  Future<BusinessEntity?> getBusinessById(String idbusiness) {
    return (select(businesss)..where((tbl) => tbl.idbusiness.equals(idbusiness)))
        .getSingleOrNull();
  }

  // 🔹 Insertar un registro
  Future<int> insertBusiness(BusinesssCompanion entity) =>
      into(businesss).insert(entity);

  // 🔹 Actualizar un registro
  Future<bool> updateBusiness(BusinessEntity entity) =>
      update(businesss).replace(entity);

  // 🔹 Eliminar un registro por idbusiness (String)
  Future<int> deleteBusiness(String idbusiness) {
    return (delete(businesss)..where((tbl) => tbl.idbusiness.equals(idbusiness)))
        .go();
  }
}
