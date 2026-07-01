import 'package:drift/drift.dart';

@DataClassName('ProductLotEntity')
class ProductLots extends Table {
  IntColumn get id => integer().autoIncrement()(); // PK autoincremental
  TextColumn get lotenumber => text().nullable()();
  TextColumn get productid => text().nullable()();
  IntColumn get quantity => integer().nullable()();
  DateTimeColumn get expirationdate => dateTime().nullable()();
  DateTimeColumn get fabricationdate => dateTime().nullable()();
}
