import 'package:drift/drift.dart';
import '/helpers/uuid_helper.dart';

@DataClassName('ThirdPartEntity')
class ThirdParts extends Table {
  // Identificador único
  TextColumn get id => text().clientDefault(generateUuid)();

  // Relación con negocio (opcional)
  TextColumn get idbusiness => text().nullable()();

  // Tipo de documento (CC, NIT, Pasaporte, etc.)
  TextColumn get documentType => text().nullable()();

  // Número de identificación
  TextColumn get documentNumber => text().nullable()();

  // Imagen o foto del tercero
  TextColumn get imageUrl => text().nullable()();

  // Tipo de tercero (cliente, proveedor, empleado, distribuidor, etc.)
  TextColumn get thirdPartType => text().nullable()();

  // Nombre completo (obligatorio)
  TextColumn get name => text()();

  // Información de contacto
  TextColumn get country => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get instagram => text().nullable()();

  // Datos adicionales
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
