import 'cart_groups.dart';
import 'products.dart';
import 'package:drift/drift.dart';

@DataClassName('TransactionEntity')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  // 👇 ahora es TextColumn porque Products.id es String (UUID)
  TextColumn get productId => text().references(Products, #id)();

  IntColumn get cartGroupId => integer().references(CartGroups, #id)();

  TextColumn get transactionType => text()(); // sale, purchase, adjustment
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real().nullable()();
  RealColumn get totalAmount => real().nullable()();
  TextColumn get concept => text().nullable()();
  IntColumn get userId => integer().nullable()();
  TextColumn get platform => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();

  // 👇 Auditoría y sincronización
  BoolColumn get syncStatus => boolean().withDefault(Constant(false))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(Constant('pending'))();
}
