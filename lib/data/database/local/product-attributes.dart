import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/products.dart';
import 'package:uuid/uuid.dart';

/// Función auxiliar para generar UUID
import '/helpers/uuid_helper.dart';

@DataClassName('ProductAttributeEntity')
class ProductAttributes extends Table {
  // 👇 Usa la función auxiliar en lugar de const Uuid().v4()
  TextColumn get id => text().clientDefault(generateUuid)();

  // 👇 productId debe ser TextColumn porque Products.id es texto (UUID)
  TextColumn get productId => text().references(Products, #id)();

  TextColumn get fieldName => text()();     // Ej: "temperatura", "lote"
  TextColumn get fieldType => text()();     // Ej: "text", "number"
  TextColumn get fieldValue => text()();    // Valor real: "4 grados", "No. 99"
  BoolColumn get isRequired => boolean().withDefault(Constant(false))();
}
