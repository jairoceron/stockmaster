import 'package:drift/drift.dart';
import '/helpers/uuid_helper.dart';

@DataClassName('ServiceEntity')
class Services extends Table {
  // Identificador único
  TextColumn get id => text().clientDefault(generateUuid)();

  // Relación con negocio o usuario dueño
  TextColumn get idBusiness => text().nullable()();

  // Categoría del servicio (ej. odontología, consultoría)
  TextColumn get idCategory => text().nullable()();

  // Nombre del servicio
  TextColumn get name => text().nullable()();

  // Descripción detallada
  TextColumn get description => text().nullable()();

  // Imagen opcional (ej. ícono o foto ilustrativa)
  TextColumn get image => text().nullable()();

  // Precio base del servicio
  RealColumn get price => real().nullable()();

  // Duración estimada en minutos (ej. cita odontológica 45 min)
  IntColumn get durationMinutes => integer().nullable()();

  // Profesional asignado (ej. odontólogo, consultor)
  TextColumn get professional => text().nullable()();

  // Impuestos aplicables
  RealColumn get taxRate => real().nullable()();

  // Estado del servicio (activo, inactivo)
  TextColumn get status => text().nullable()();

  // Información de sincronización
  TextColumn get syncState => text().nullable()();
  BoolColumn get syncStatus => boolean().nullable()();
  BoolColumn get isDemo => boolean().nullable()();

  // Timestamps
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
