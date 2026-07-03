import 'package:drift/drift.dart';
import '/helpers/uuid_helper.dart';

@DataClassName('SaleEntity')
class Sales extends Table {
  // Identificador único de la venta
  TextColumn get id => text().clientDefault(generateUuid)();

  // Relación con cliente (ThirdPartEntity)
  TextColumn get clientId => text()();

  // Fecha de la venta
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();

  // Método de pago (efectivo, tarjeta, transferencia, etc.)
  TextColumn get paymentMethod => text().nullable()();

  // Total pagado en la venta
  RealColumn get totalAmount => real()();

  // Información de sincronización (opcional)
  TextColumn get syncState => text().nullable()();
  BoolColumn get syncStatus => boolean().nullable()();
  BoolColumn get isDemo => boolean().nullable()();

  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

