import 'package:drift/drift.dart';

@DataClassName('BusinessEntity')
class Businesss extends Table {
  // PRIMARY KEY
  TextColumn get idbusiness => text()();

  // Campos de texto
  TextColumn get name => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get direccion => text().nullable()();
  TextColumn get pais => text().nullable()();
  TextColumn get ciudad => text().nullable()();
  TextColumn get latitud => text().nullable()();
  TextColumn get longitud => text().nullable()();
  TextColumn get acteconomica => text().nullable()();
  TextColumn get celular => text().nullable()();

  // createdat como DateTime con valor por defecto
  DateTimeColumn get createdat =>
      dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {idbusiness};
}
