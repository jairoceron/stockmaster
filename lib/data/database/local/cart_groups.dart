

import 'package:drift/drift.dart';


@DataClassName('CartGroupEntity')
class CartGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()(); // Carrito1, Orden mesa 5
  BoolColumn get processed => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  // 👇 Auditoría y escalabilidad
  BoolColumn get syncStatus => boolean().withDefault(Constant(false))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(Constant('pending'))();
}
