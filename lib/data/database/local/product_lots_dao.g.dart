// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_lots_dao.dart';

// ignore_for_file: type=lint
mixin _$ProductLotsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductLotsTable get productLots => attachedDatabase.productLots;
  ProductLotsDaoManager get managers => ProductLotsDaoManager(this);
}

class ProductLotsDaoManager {
  final _$ProductLotsDaoMixin _db;
  ProductLotsDaoManager(this._db);
  $$ProductLotsTableTableManager get productLots =>
      $$ProductLotsTableTableManager(_db.attachedDatabase, _db.productLots);
}
