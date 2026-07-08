import 'package:drift/drift.dart';

import '../DTO/sale_with_client.dart';
import '../database/local/app_database.dart';


class SalesRepository {
  final AppDatabase db;

  SalesRepository(this.db);

  // Obtener todas las ventas con datos del cliente (si existe)
  Future<List<SaleWithClient>> getSalesWithClients() async {
    final query = db.select(db.sales).join([
      leftOuterJoin(
        db.thirdParts,
        db.thirdParts.id.equalsExp(db.sales.clientId),
      ),
    ])
      ..orderBy([OrderingTerm.desc(db.sales.date)]);

    final rows = await query.get();

    return rows.map((row) {
      final sale = row.readTable(db.sales);
      final client = row.readTableOrNull(db.thirdParts);

      return SaleWithClient(
        saleId: sale.id,
        date: sale.date,
        totalAmount: sale.totalAmount,
        clientName: client?.name ?? "Venta rápida",
        clientImageUrl: client?.imageUrl,
      );
    }).toList();
  }
}
