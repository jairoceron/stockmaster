// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_inventories_dao.dart';

// ignore_for_file: type=lint
mixin _$TypeInventoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $TypeInventoriesTable get typeInventories => attachedDatabase.typeInventories;
  TypeInventoriesDaoManager get managers => TypeInventoriesDaoManager(this);
}

class TypeInventoriesDaoManager {
  final _$TypeInventoriesDaoMixin _db;
  TypeInventoriesDaoManager(this._db);
  $$TypeInventoriesTableTableManager get typeInventories =>
      $$TypeInventoriesTableTableManager(
        _db.attachedDatabase,
        _db.typeInventories,
      );
}
