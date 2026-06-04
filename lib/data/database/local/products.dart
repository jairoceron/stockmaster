import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '/helpers/uuid_helper.dart';



@DataClassName('ProductEntity')
class Products extends Table {
  TextColumn get id => text().clientDefault(generateUuid)(); // 👈 usa la función
  TextColumn get idbusiness => text().nullable()();
  TextColumn get idcategory => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get stock => integer().nullable()();
  RealColumn get price => real().nullable()();

  TextColumn get owner => text().nullable()();
  TextColumn get barcode => text().nullable()();
  IntColumn get stockminimumlevel => integer().nullable()();
  TextColumn get deviceid => text().nullable()();
  TextColumn get platform => text().nullable()();
  TextColumn get ubicacion => text().nullable()();
  TextColumn get bodega => text().nullable()();




  DateTimeColumn get lastsyncedat => dateTime().nullable()();
  DateTimeColumn get createdat => dateTime().nullable()();

/*
  TextColumn get syncstate => text().withDefault(Constant('pending'))();
  BoolColumn get syncstatus => boolean().withDefault(Constant(false))();
  BoolColumn get isdemo => boolean().withDefault(Constant(false))();
*/
  TextColumn get syncstate => text().nullable()();
  BoolColumn get syncstatus => boolean().nullable()();
  BoolColumn get isdemo => boolean().nullable()();



  @override
  Set<Column> get primaryKey => {id}; // 👈 define la PK

}
