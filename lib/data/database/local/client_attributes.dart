import 'package:drift/drift.dart';


@DataClassName('ClientAttributesEntity')
class ClientAttributes extends Table {
  // Identificador único de cada atributo
  IntColumn get id => integer().autoIncrement()();

  // UUID opcional para sincronización/distribución
  TextColumn get uuid => text().nullable()();

  // Tipo de cliente al que aplica (ej. "carnicería", "salamentaria")
  TextColumn get clientType => text()();

  // Nombre del campo (ej. "proveedor", "factura_compra")
  TextColumn get fieldName => text()();

  // Tipo de dato (ej. "text", "number", "date")
  TextColumn get fieldType => text()();

  // Si es obligatorio o no
  BoolColumn get isRequired => boolean().withDefault(Constant(false))();

  // Orden de aparición en el formulario
  IntColumn get displayOrder => integer().nullable()();
}
