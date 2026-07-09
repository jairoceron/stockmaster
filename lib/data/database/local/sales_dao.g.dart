// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_dao.dart';

// ignore_for_file: type=lint
mixin _$SalesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SalesTable get sales => attachedDatabase.sales;
  $ThirdPartsTable get thirdParts => attachedDatabase.thirdParts;
  SalesDaoManager get managers => SalesDaoManager(this);
}

class SalesDaoManager {
  final _$SalesDaoMixin _db;
  SalesDaoManager(this._db);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db.attachedDatabase, _db.sales);
  $$ThirdPartsTableTableManager get thirdParts =>
      $$ThirdPartsTableTableManager(_db.attachedDatabase, _db.thirdParts);
}
