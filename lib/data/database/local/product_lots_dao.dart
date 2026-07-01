import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/product_lots.dart';
import 'app_database.dart'; // tu archivo principal de BD

part 'product_lots_dao.g.dart';

@DriftAccessor(tables: [ProductLots])
class ProductLotsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductLotsDaoMixin {
  final AppDatabase db;

  ProductLotsDao(this.db) : super(db);

  // 🔹 Insertar un nuevo lote
  Future<int> insertLot(ProductLotsCompanion lot) =>
      into(productLots).insert(lot);

  // 🔹 Actualizar un lote existente
  Future<bool> updateLot(ProductLotEntity lot) =>
      update(productLots).replace(lot);

  // 🔹 Eliminar un lote por ID
  Future<int> deleteLot(int id) =>
      (delete(productLots)..where((tbl) => tbl.id.equals(id))).go();

  // 🔹 Obtener todos los lotes
  Future<List<ProductLotEntity>> getAllLots() =>
      select(productLots).get();

  // 🔹 Obtener lotes por producto
  Future<List<ProductLotEntity>> getLotsByProduct(String productId) =>
      (select(productLots)..where((tbl) => tbl.productid.equals(productId))).get();

  // 🔹 Obtener lotes próximos a vencer
  Future<List<ProductLotEntity>> getExpiringLots(DateTime limitDate) =>
      (select(productLots)..where((tbl) => tbl.expirationdate.isSmallerOrEqualValue(limitDate))).get();

  // 🔹 Stream en tiempo real de todos los lotes
  Stream<List<ProductLotEntity>> watchAllLots() =>
      select(productLots).watch();
}
