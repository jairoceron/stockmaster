import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/users.dart';

import 'app_database.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase>
    with _$UsersDaoMixin {
  UsersDao(AppDatabase db) : super(db);

  // 🔹 Obtener todos los registros
  Future<List<UsersEntity>> getAllUsers() =>
      select(users).get();

  // 🔹 Obtener un registro por id
  Future<UsersEntity?> getUserById(int id) {
    return (select(users)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  // 🔹 Insertar un registro
  Future<int> insertUser(UsersCompanion entity) =>
      into(users).insert(entity);

  // 🔹 Actualizar un registro
  Future<bool> updateUser(UsersEntity entity) =>
      update(users).replace(entity);

  // 🔹 Eliminar un registro
  Future<int> deleteUser(int id) {
    return (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  }
}

