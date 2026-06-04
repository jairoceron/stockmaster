// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_attributes_dao.dart';

// ignore_for_file: type=lint
mixin _$ClientAttributesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientAttributesTable get clientAttributes =>
      attachedDatabase.clientAttributes;
  ClientAttributesDaoManager get managers => ClientAttributesDaoManager(this);
}

class ClientAttributesDaoManager {
  final _$ClientAttributesDaoMixin _db;
  ClientAttributesDaoManager(this._db);
  $$ClientAttributesTableTableManager get clientAttributes =>
      $$ClientAttributesTableTableManager(
        _db.attachedDatabase,
        _db.clientAttributes,
      );
}
