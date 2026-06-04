import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/client_attributes.dart';
import 'package:stockmaster/data/database/local/client_attributes.dart';
import '../../../models/client_attribute.dart';
import 'app_database.dart';

part 'client_attributes_dao.g.dart';

@DriftAccessor(tables: [ClientAttributes])
class ClientAttributesDao extends DatabaseAccessor<AppDatabase>
    with _$ClientAttributesDaoMixin {
  ClientAttributesDao(AppDatabase db) : super(db);

  // 🔎 Obtener todos los atributos
  Future<List<ClientAttribute>> getAllAttributes() async {
    final rows = await select(clientAttributes).get();
    return rows.map((e) => _mapEntityToModel(e)).toList();
  }

  Future<List<ClientAttributesEntity>> getAttributesByBusinessType(String type) {
    return (select(clientAttributes)..where((t) => t.clientType.equals(type))).get();
  }


  // 🔎 Obtener atributos por tipo de cliente
  Future<List<ClientAttribute>> getAttributesByClientType(String type) async {
    final rows = await (select(clientAttributes)
      ..where((tbl) => tbl.clientType.equals(type))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.displayOrder)]))
        .get();
    return rows.map((e) => _mapEntityToModel(e)).toList();
  }

  // ➕ Insertar un nuevo atributo
  Future<int> insertAttribute(ClientAttributesCompanion entry) =>
      into(clientAttributes).insert(entry);

  // ✏️ Actualizar un atributo existente
  Future<bool> updateAttribute(ClientAttribute entry) {
    final entity = ClientAttributesEntity(
      id: entry.id ?? 0,
      uuid: entry.uuid,
      clientType: entry.clientType,
      fieldName: entry.fieldName,
      fieldType: entry.fieldType,
      isRequired: entry.isRequired,
      displayOrder: entry.displayOrder,
    );
    return update(clientAttributes).replace(entity);
  }

  // ❌ Eliminar un atributo
  Future<int> deleteAttribute(int id) =>
      (delete(clientAttributes)..where((tbl) => tbl.id.equals(id))).go();

  // 🔄 Mapeo entre entidad generada y modelo de dominio
  ClientAttribute _mapEntityToModel(ClientAttributesEntity e) {
    return ClientAttribute(
      id: e.id,
      uuid: e.uuid,
      clientType: e.clientType,
      fieldName: e.fieldName,
      fieldType: e.fieldType,
      isRequired: e.isRequired,
      displayOrder: e.displayOrder,
    );
  }
}
