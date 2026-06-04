// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_groups_dao.dart';

// ignore_for_file: type=lint
mixin _$CartGroupsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CartGroupsTable get cartGroups => attachedDatabase.cartGroups;
  CartGroupsDaoManager get managers => CartGroupsDaoManager(this);
}

class CartGroupsDaoManager {
  final _$CartGroupsDaoMixin _db;
  CartGroupsDaoManager(this._db);
  $$CartGroupsTableTableManager get cartGroups =>
      $$CartGroupsTableTableManager(_db.attachedDatabase, _db.cartGroups);
}
