import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '/helpers/uuid_helper.dart';


@DataClassName('ItemsEntity')
class Items extends Table {
  // Identificador único universal (UUID como texto)
  TextColumn get id => text().clientDefault(generateUuid)(); // 👈 usa la función

  // Tenant ID (multi‑tenant apps)
  TextColumn get tenantId => text()();

  // Nombre del producto o servicio
  TextColumn get nombre => text()();

  // Tipo de ítem: "producto" o "servicio"
  TextColumn get tipo => text()();

  // Precio base
  RealColumn get precioBase => real()();

  // Descripción opcional
  TextColumn get descripcion => text().nullable()();

  // Fecha de creación
  DateTimeColumn get creadoEn => dateTime().withDefault(currentDateAndTime)();

  // Fecha de última actualización
  DateTimeColumn get actualizadoEn => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
