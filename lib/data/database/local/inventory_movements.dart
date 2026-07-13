import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/products.dart';
import '/helpers/uuid_helper.dart'; // si usas generateUuid()

@DataClassName('InventoryMovementEntity')
class InventoryMovements extends Table {
  // 🔹 Identificador único
  TextColumn get id => text().clientDefault(generateUuid)(); // UUID como en Products

  // 🔹 Relación con producto
  TextColumn get productId => text().references(Products, #id)();

  // 🔹 Tipo de movimiento: entrada o salida
  TextColumn get movementType =>
      text().check(movementType.isIn(['entrada', 'salida']))();

  // 🔹 Cantidad del movimiento
  IntColumn get quantity => integer()();

  // 🔹 Stock antes del movimiento
  IntColumn get previousStock => integer()();

  // 🔹 Stock después del movimiento
  IntColumn get newStock => integer()();

  // 🔹 Fecha y hora del movimiento
  DateTimeColumn get timestamp =>
      dateTime().clientDefault(() => DateTime.now())();

  // 🔹 Nota o descripción opcional
  TextColumn get note => text().nullable()();

  // 🔹 Usuario o dispositivo que realizó el movimiento (opcional)
  TextColumn get deviceId => text().nullable()();
  TextColumn get owner => text().nullable()();

  // 🔹 Estado de sincronización (si manejas offline)
  TextColumn get syncState => text().nullable()();
  BoolColumn get syncStatus => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
