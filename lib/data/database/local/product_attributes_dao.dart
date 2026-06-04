import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/product-attributes.dart';
import 'app_database.dart';

part 'product_attributes_dao.g.dart';

@DriftAccessor(tables: [ProductAttributes])
class ProductAttributesDao extends DatabaseAccessor<AppDatabase>
    with _$ProductAttributesDaoMixin {
  ProductAttributesDao(AppDatabase db) : super(db);

  // Obtener todos los atributos
  Future<List<ProductAttributeEntity>> getAllAttributes() =>
      select(productAttributes).get();

  // Obtener atributos de un producto específico (UUID string)
  Future<List<ProductAttributeEntity>> getAttributesByProduct(String productId) {
    return (select(productAttributes)
      ..where((tbl) => tbl.productId.equals(productId)))
        .get();
  }

  // Obtener atributos filtrados por tipo de inventario
  Future<List<ProductAttributeEntity>> getAttributesByInventoryType(String type) {
    return (select(productAttributes)
      ..where((tbl) => tbl.fieldName.equals(type))) // 👈 ajusta según tu modelo
        .get();
  }

  // Insertar un nuevo atributo
  Future<int> insertAttribute(ProductAttributesCompanion entry) =>
      into(productAttributes).insert(entry);

  // Actualizar un atributo existente
  Future<bool> updateAttribute(ProductAttributeEntity entity) =>
      update(productAttributes).replace(entity);

  // Eliminar un atributo
  Future<int> deleteAttribute(String id) =>
      (delete(productAttributes)..where((tbl) => tbl.id.equals(id))).go();
}
