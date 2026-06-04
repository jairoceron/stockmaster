// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_dao.dart';

// ignore_for_file: type=lint
mixin _$BusinessDaoMixin on DatabaseAccessor<AppDatabase> {
  $BusinesssTable get businesss => attachedDatabase.businesss;
  BusinessDaoManager get managers => BusinessDaoManager(this);
}

class BusinessDaoManager {
  final _$BusinessDaoMixin _db;
  BusinessDaoManager(this._db);
  $$BusinesssTableTableManager get businesss =>
      $$BusinesssTableTableManager(_db.attachedDatabase, _db.businesss);
}
