import 'package:drift/drift.dart';
import 'app_database.dart';
import 'cart_groups.dart'; // donde está definido AppDatabase y CartGroups

part 'cart_groups_dao.g.dart';

@DriftAccessor(tables: [CartGroups])
class CartGroupsDao extends DatabaseAccessor<AppDatabase>
    with _$CartGroupsDaoMixin {
  CartGroupsDao(AppDatabase db) : super(db);

  // 🔹 Obtener todos los carritos
  Future<List<CartGroupEntity>> getAllCartGroups() =>
      select(cartGroups).get();

  // 🔹 Obtener carritos no procesados
  Future<List<CartGroupEntity>> getOpenCartGroups() =>
      (select(cartGroups)..where((c) => c.processed.equals(false))).get();

  // 🔹 Insertar un nuevo carrito
  Future<int> insertCartGroup(CartGroupsCompanion entry) =>
      into(cartGroups).insert(entry);

  // 🔹 Actualizar estado de procesado
  Future<int> markAsProcessed(int id) {
    return (update(cartGroups)..where((c) => c.id.equals(id)))
        .write(const CartGroupsCompanion(
      processed: Value(true),
    ));
  }

  // 🔹 Actualizar estado de sincronización
  Future<int> updateSyncStatus(
      int id, {
        required bool status,
        String? state,
      }) {
    return (update(cartGroups)..where((c) => c.id.equals(id)))
        .write(CartGroupsCompanion(
      syncStatus: Value(status),
      syncState: Value(state ?? (status ? 'synced' : 'pending')),
      lastSyncedAt: Value(DateTime.now()),
    ));
  }

  // 🔹 Eliminar carrito
  Future<int> deleteCartGroup(int id) =>
      (delete(cartGroups)..where((c) => c.id.equals(id))).go();
}
