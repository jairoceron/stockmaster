import 'package:drift/drift.dart';

import '../../../models/transaction.dart';
import 'app_database.dart';
import 'transactions.dart'; // archivo donde definiste la tabla Transactions

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionDaoMixin {
  TransactionDao(AppDatabase db) : super(db);



  //---------------
// Total de ventas del día (suma de totalAmount)
  Future<double> getTodaySalesTotal() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final query = select(transactions)
      ..where((tbl) =>
      tbl.transactionType.equals('sale') &
      tbl.createdAt.isBiggerOrEqualValue(startOfDay));

    final rows = await query.get();
    return rows.fold<double>(
        0.0, (sum, row) => sum + (row.totalAmount ?? 0.0));
  }


  //---------------

  // Insertar transacción
  Future<int> insertTransaction(TransactionsCompanion entry) =>
      into(transactions).insert(entry);

  // Obtener todas las transacciones
  Future<List<TransactionEntity>> getAllTransactions() =>
      select(transactions).get();

  Future<TransactionEntity?> getTransactionById(int id) =>
      (select(transactions)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // Eliminar transacción
  Future<int> deleteTransaction(int id) =>
      (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
}
