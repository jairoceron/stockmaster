// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_dao.dart';

// ignore_for_file: type=lint
mixin _$ServicesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ServicesTable get services => attachedDatabase.services;
  ServicesDaoManager get managers => ServicesDaoManager(this);
}

class ServicesDaoManager {
  final _$ServicesDaoMixin _db;
  ServicesDaoManager(this._db);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db.attachedDatabase, _db.services);
}
