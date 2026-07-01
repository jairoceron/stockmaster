import 'package:drift/drift.dart';

@DataClassName('TypeInventoryEntity')
class TypeInventories extends Table {
  // ID manual (ej. 1 = Droguería, 2 = Ferretería)
  IntColumn get id => integer()();

  // Nombre en español
  TextColumn get nombrees => text().withLength(min: 1, max: 100)();

  // Nombre en inglés
  TextColumn get nombreen => text().withLength(min: 1, max: 100)();

  // Ruta de la imagen (asset o URL)
  TextColumn get pathimage => text().withLength(min: 1, max: 255)();

  // Descripción opcional
  TextColumn get descripcion => text().nullable()();

  // Activo/inactivo
  BoolColumn get activo => boolean().withDefault(const Constant(true))();

  // Auditoría
  DateTimeColumn get createdat =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedat =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id}; // ← clave primaria manual
}
