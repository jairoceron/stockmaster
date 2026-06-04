import 'package:drift/drift.dart';
import 'businesss.dart';

@DataClassName('UsersEntity')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()(); // PK interno

  // tenantid referencia a business.idbusiness (tipo TEXT)
  TextColumn get tenantid => text().references(Businesss, #idbusiness)();

  TextColumn get name => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get direccion => text().nullable()();
  TextColumn get pais => text().nullable()();
  TextColumn get ciudad => text().nullable()();
  TextColumn get celular => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  TextColumn get username => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get idbusiness => text().nullable()(); // también tipo TEXT
  IntColumn get idrol => integer().nullable()();
  BoolColumn get isGuest => boolean().nullable()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get platform => text().nullable()();
}
