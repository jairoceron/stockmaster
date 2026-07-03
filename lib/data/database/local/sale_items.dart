import 'package:drift/drift.dart';
import '/helpers/uuid_helper.dart';

@DataClassName('SaleItemEntity')
class SaleItems extends Table {
  // Identificador único del detalle
  TextColumn get id => text().clientDefault(generateUuid)();

  // Relación con la venta
  TextColumn get saleId => text()();

  // Relación con el servicio adquirido
  TextColumn get serviceId => text()();

  // Precio del servicio en el momento de la venta
  RealColumn get price => real()();

  // Cantidad (normalmente 1 para servicios)
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  // Subtotal calculado (price * quantity)
  RealColumn get subtotal => real()();

  @override
  Set<Column> get primaryKey => {id};
}
