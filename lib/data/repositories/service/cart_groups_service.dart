import 'package:drift/drift.dart';

import '../../../models/cart_group.dart';
import '../../database/local/app_database.dart';
import '../../database/local/cart_groups_dao.dart';


/// Servicio de negocio para manejar carritos.
/// Encapsula la lógica de negocio y usa el DAO para acceder a la base de datos.
class CartGroupsService {
  final CartGroupsDao _dao;

  CartGroupsService(this._dao);

  /// 🔹 Obtener todos los carritos como modelos de dominio
  Future<List<CartGroup>> getAllCartGroups() async {
    final entities = await _dao.getAllCartGroups();
    return entities.map((e) => CartGroup.fromEntity(e)).toList();
  }

  /// 🔹 Obtener carritos abiertos (no procesados)
  Future<List<CartGroup>> getOpenCartGroups() async {
    final entities = await _dao.getOpenCartGroups();
    return entities.map((e) => CartGroup.fromEntity(e)).toList();
  }

  /// 🔹 Crear un nuevo carrito
  Future<CartGroup> createCartGroup(String? name) async {
    final now = DateTime.now();
    final entry = CartGroupsCompanion.insert(
      name: Value(name),
      createdAt: Value(now),
      processed: const Value(false),
      syncStatus: const Value(false),
      syncState: const Value('pending'),
    );

    final id = await _dao.insertCartGroup(entry);

    return CartGroup(
      id: id,
      name: name,
      createdAt: now,
      processed: false,
      syncStatus: false,
      syncState: 'pending',
    );
  }

  /// 🔹 Marcar carrito como procesado
  Future<void> markAsProcessed(int id) async {
    await _dao.markAsProcessed(id);
  }

  /// 🔹 Actualizar estado de sincronización
  Future<void> updateSyncStatus(int id, {required bool status, String? state}) async {
    await _dao.updateSyncStatus(id, status: status, state: state);
  }

  /// 🔹 Eliminar carrito
  Future<void> deleteCartGroup(int id) async {
    await _dao.deleteCartGroup(id);
  }
}
