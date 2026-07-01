// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_parts_dao.dart';

// ignore_for_file: type=lint
mixin _$ThirdPartsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ThirdPartsTable get thirdParts => attachedDatabase.thirdParts;
  ThirdPartsDaoManager get managers => ThirdPartsDaoManager(this);
}

class ThirdPartsDaoManager {
  final _$ThirdPartsDaoMixin _db;
  ThirdPartsDaoManager(this._db);
  $$ThirdPartsTableTableManager get thirdParts =>
      $$ThirdPartsTableTableManager(_db.attachedDatabase, _db.thirdParts);
}
