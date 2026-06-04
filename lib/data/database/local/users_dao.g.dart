// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_dao.dart';

// ignore_for_file: type=lint
mixin _$UsersDaoMixin on DatabaseAccessor<AppDatabase> {
  $BusinesssTable get businesss => attachedDatabase.businesss;
  $UsersTable get users => attachedDatabase.users;
  UsersDaoManager get managers => UsersDaoManager(this);
}

class UsersDaoManager {
  final _$UsersDaoMixin _db;
  UsersDaoManager(this._db);
  $$BusinesssTableTableManager get businesss =>
      $$BusinesssTableTableManager(_db.attachedDatabase, _db.businesss);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
}
